require 'spec_helper'
require 'discounts/pricing/amount'

describe Discounts::Pricing::Amount do
  before do
    @items = 5.times.map { discounted_product('TT', 10) }
    @pricing = Discounts::Pricing::Amount.new(0.1)
  end

  it 'should apply discount to single item' do
    item = @items.sample
    expect{@pricing.apply([item])}.to change(item, :price).to(9.9)
  end

  it 'should apply discount to all items' do
    expect{@pricing.apply(@items)}.to change(@items.sample, :price).to(9.9)
  end
end
