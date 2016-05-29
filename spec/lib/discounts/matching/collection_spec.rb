require 'spec_helper'
require 'discounts/product'
require 'discounts/matching/collection'

describe Discounts::Matching::Collection do
  describe 'single matching item' do
    before do
      @matching = Discounts::Matching::Collection.new(['p1'])
    end

    it 'should be applicable for list with correct item' do
      expect(@matching.applicable_for?(products_list(%w(p3 p2 p1)))).to be_truthy
    end

    it 'should be applicable for list with several correct items' do
      expect(@matching.applicable_for?(products_list(%w(p1 p3 p2 p1)))).to be_truthy
    end

    it 'should not be applicable for list without item' do
      expect(@matching.applicable_for?(products_list(%w(p3 p2 p6)))).to be_falsey
    end

    it 'should return first matched item in collection' do
      expect(@matching.extract_matched_items(products_list(%w(p1 p3 p2 p1)))).to eq(products_list(%w(p1)))
    end

    it 'should return filter all matched items in collection' do
      expect(@matching.filter_matched_items(products_list(%w(p1 p3 p2 p1)))).to eq(products_list(%w(p1 p1)))
    end
  end

  describe 'several items' do
    before do
      @matching = Discounts::Matching::Collection.new(%w(p1 p2))
    end

    it 'should be applicable for list with correct item' do
      expect(@matching.applicable_for?(products_list(%w(p2 p3 p5 p1)))).to be_truthy
    end

    it 'should be applicable for list with several correct items' do
      expect(@matching.applicable_for?(products_list(%w(p2 p2 p3 p1 p5 p1)))).to be_truthy
    end

    it 'should be applicable for list with several items above correct' do
      expect(@matching.applicable_for?(products_list(%w(p2 p3 p1 p5 p1)))).to be_truthy
    end

    it 'should not be applicable for list without item' do
      expect(@matching.applicable_for?(products_list(%w(p4 p3 p5)))).to be_falsey
    end

    it 'should return first matched items in collection' do
      expect(@matching.extract_matched_items(products_list(%w(p2 p3 p1 p5 p1 p2)))).to eq(products_list(%w(p1 p2)))
    end

    it 'should modify original on extract collection' do
      items = products_list(%w(p2 p3 p1 p5 p1 p2))
      @matching.extract_matched_items(items)
      expect(items).to eq(products_list(%w(p3 p5 p1 p2)))
    end

    it 'should return first matched items in partial collection' do
      expect(@matching.extract_matched_items(products_list(%w(p2 p3 p2)))).to eq(products_list(%w(p2)))
    end

    it 'should return filter all matched items in collection' do
      expect(@matching.filter_matched_items(products_list(%w(p2 p3 p1 p5 p1 p2)))).to eq(products_list(%w(p2 p1 p1 p2)))
    end

    it 'should return all filtered items in partial collection' do
      expect(@matching.filter_matched_items(products_list(%w(p2 p3 p2)))).to eq(products_list(%w(p2 p2)))
    end
  end

  describe 'several identical items' do
    before do
      @matching = Discounts::Matching::Collection.new(%w(p1 p1))
    end

    it 'should be applicable for list with duplicated item' do
      expect(@matching.applicable_for?(products_list(%w(p1 p3 p2 p1)))).to be_truthy
    end

    it 'should be applicable for list with several correct items' do
      expect(@matching.applicable_for?(products_list(%w(p1 p1 p3 p2 p1)))).to be_truthy
    end

    it 'should not be applicable for list without item' do
      expect(@matching.applicable_for?(products_list(%w(p3 p2 p6)))).to be_falsey
    end

    it 'should not be applicable for list without doubled item' do
      expect(@matching.applicable_for?(products_list(%w(p1 p3 p2 p6)))).to be_falsey
    end

    it 'should return first matched items in collection' do
      expect(@matching.extract_matched_items(products_list(%w(p1 p3 p1 p5 p1 p2 p1)))).to eq(products_list(%w(p1 p1)))
    end

    it 'should return filter all matched items in collection' do
      expect(@matching.filter_matched_items(products_list(%w(p1 p3 p1 p5 p1 p2 p1)))).to eq(products_list(%w(p1 p1 p1 p1)))
    end
  end
end