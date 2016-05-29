require 'spec_helper'
require 'discounts/pricing/percent'

describe Discounts::Pricing::Percent do
  before do
    @items = 5.times.map { discounted_product('TT', 10) }
    @pricing = Discounts::Pricing::Percent.new(20)
  end

  it 'should apply discount to single item' do
    item = @items.sample
    expect{@pricing.apply([item])}.to change(item, :price).by(-2.0)
  end

  it 'should apply discount to all items' do
    expect{@pricing.apply(@items)}.to change(@items.sample, :price).by(-2.0)
  end
end
