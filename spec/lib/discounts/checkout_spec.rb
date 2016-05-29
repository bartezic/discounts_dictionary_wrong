require 'spec_helper'
require 'discounts/checkout'
require 'discounts/product_catalog'
require 'discounts/matching/double_item'
require 'discounts/matching/several_items'
require 'discounts/pricing/percent'
require 'discounts/pricing/amount'
require 'discounts/rules/all_matched'
require 'discounts/rules/items_pack'

describe Discounts::Checkout do
  before do
    @tea = Discounts::ProductCatalog.item_by_code('FR')
    @berries = Discounts::ProductCatalog.item_by_code('SR')
    @coffee = Discounts::ProductCatalog.item_by_code('CF')
  end

  def total_price(*items)
    items.each {|item| @checkout.scan(item.code) }
    @checkout.total
  end

  describe 'no discounts' do
    before do
      @checkout = Discounts::Checkout.new
    end

    it 'should return correct price without items' do
      expect(total_price).to eq(0)
    end

    it 'should return correct price for single item' do
      expect(total_price(@tea)).to eq(@tea.price)
    end

    it 'should return correct price for several items' do
      expect(total_price(@tea, @tea)).to eq(@tea.price * 2)
    end
  end

  describe 'simple one free discount' do
    before do
      @matcher = Discounts::Matching::DoubleItem.new('FR')
      @discount = Discounts::Pricing::DiscountsSequence.new(0, 100)
      @rule = Discounts::Rules::ItemsPack.new(@matcher, @discount)
      @checkout = Discounts::Checkout.new(@rule)
    end

    it 'should return correct price without items' do
      expect(total_price).to eq(0)
    end

    it 'should return correct price for single item' do
      expect(total_price(@tea)).to eq(3.11)
    end

    it 'should return correct price for double items' do
      expect(total_price(@tea, @tea)).to eq(3.11)
    end

    it 'should return correct price for double items with other' do
      expect(total_price(@tea, @berries, @tea)).to eq(3.11 + 5.0)
    end

    it 'should return correct price for triple items' do
      expect(total_price(@tea, @tea, @tea)).to eq(6.22)
    end

    it 'should return correct price for quadripple items' do
      expect(total_price(@tea, @tea, @tea, @tea)).to eq(6.22)
    end
  end

  describe 'several items general discount' do
    before do
      @matcher = Discounts::Matching::SeveralItems.new('FR', 3)
      @discount = Discounts::Pricing::Percent.new(50)
      @rule = Discounts::Rules::AllMatched.new(@matcher, @discount)
      @checkout = Discounts::Checkout.new(@rule)
    end

    it 'should return correct price without items' do
      expect(total_price).to eq(0)
    end

    it 'should return correct price for single item' do
      expect(total_price(@tea)).to eq(@tea.price)
    end

    it 'should return correct price for double items' do
      expect(total_price(@tea, @tea)).to eq(6.22)
    end

    it 'should return correct price for double items with other' do
      expect(total_price(@tea, @tea, @berries, @tea)).to eq(9.68)
    end

    it 'should return correct price for triple items' do
      expect(total_price(@tea, @tea, @tea)).to eq(4.68)
    end

    it 'should return correct price for quadripple items' do
      expect(total_price(@tea, @tea, @tea, @tea)).to eq(6.24)
    end
  end

  describe 'multiple discounts' do
    before do
      @strawberries_rule = Discounts::Rules::AllMatched.new(Discounts::Matching::SeveralItems.new('SR', 3), Discounts::Pricing::Amount.new(0.5))
      @tea_rule = Discounts::Rules::ItemsPack.new(Discounts::Matching::DoubleItem.new('FR'), Discounts::Pricing::DiscountsSequence.new(0, 100))
      @checkout = Discounts::Checkout.new(@tea_rule, @strawberries_rule)
    end

    it 'should return correct price without items' do
      expect(total_price).to eq(0)
    end

    it 'should return correct price when both rules matched' do
      expect(total_price(@tea, @berries, @tea, @tea, @coffee)).to eq(22.45)
    end

    it 'should return correct price when tea rule matched' do
      expect(total_price(@tea, @tea)).to eq(3.11)
    end

    it 'should return correct price when berries rule matched' do
      expect(total_price(@berries, @berries, @tea, @berries)).to eq(16.61)
    end
  end
end