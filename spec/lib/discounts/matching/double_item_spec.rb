require 'spec_helper'
require 'discounts/product'
require 'discounts/matching/double_item'

describe Discounts::Matching::DoubleItem do
  describe 'single matching item' do
    before do
      @item = product('p1')
      @matching = Discounts::Matching::DoubleItem.new(@item.code)
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