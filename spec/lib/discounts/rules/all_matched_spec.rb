require 'spec_helper'
require 'discounts/rules/all_matched'

describe Discounts::Rules::AllMatched do
  before do
    @items = products_list(%w(1 2 3))
    @matcher = double(:matcher, applicable_for?: true, filter_matched_items: @items.sample(2))
    @pricing = double(:pricing, apply: true)
    @rule = Discounts::Rules::AllMatched.new(@matcher, @pricing)
  end

  it 'should not apply discounts if not applicable' do
    allow(@matcher).to receive(:applicable_for?).and_return false
    expect(@pricing).to_not receive(:apply)
    @rule.apply(@items)
  end

  it 'should apply discount on all filtered items' do
    expect(@pricing).to receive(:apply).with(@matcher.filter_matched_items(@items))
    @rule.apply(@items)
  end
end