require 'spec_helper'
require 'discounts/pricing/discounts_sequence'

describe Discounts::Pricing::DiscountsSequence do
  before do
    @items = 5.times.map { discounted_product('TT', 10) }
    @pricing = Discounts::Pricing::DiscountsSequence.new(0, 20, 40)
  end

  it 'should not apply discount to first item in sequence' do
    expect{@pricing.apply(@items)}.to_not change(@items[0], :price)
  end

  it 'should apply discount to second item in sequence' do
    expect{@pricing.apply(@items)}.to change(@items[1], :price).by(-2.0)
  end

  it 'should apply discount to third item in sequence' do
    expect{@pricing.apply(@items)}.to change(@items[2], :price).by(-4.0)
  end

  it 'should not apply discount to third item in sequence' do
    expect{@pricing.apply(@items)}.to_not change(@items[3], :price)
  end

  it 'should work with smaller sequences then defined' do
    expect{@pricing.apply(@items.first(2))}.to change(@items[1], :price).by(-2.0)
  end

  it 'should work without defined sequence' do
    @pricing = Discounts::Pricing::DiscountsSequence.new
    expect{@pricing.apply(@items)}.to_not change(@items.sample, :price)
  end
end
