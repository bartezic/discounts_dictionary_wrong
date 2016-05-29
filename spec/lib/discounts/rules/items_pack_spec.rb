require 'spec_helper'
require 'discounts/rules/items_pack'

describe Discounts::Rules::ItemsPack do
  before do
    @items = products_list(%w(1 2 3 4 5))
    @filtered = @items.sample(4)
    @matcher = double(:matcher, filter_matched_items: @filtered)
    @pricing = double(:pricing, apply: true)
    @rule = Discounts::Rules::ItemsPack.new(@matcher, @pricing)
  end

  it 'should not apply discounts if not applicable' do
    allow(@matcher).to receive(:applicable_for?).and_return false
    expect(@pricing).to_not receive(:apply)
    @rule.apply(@items)
  end

  describe 'two items groups' do
    before do
      @selected = @filtered.sample(2)
      allow(@matcher).to receive(:applicable_for?).and_return true, true, false
      allow(@matcher).to receive(:extract_matched_items).and_return @selected, @filtered - @selected
    end

    it 'should apply discount with first group' do
      expect(@pricing).to receive(:apply).with(@selected)
      @rule.apply(@items)
    end

    it 'should not apply discount with second group' do
      expect(@pricing).to receive(:apply).once
      @rule.apply(@items)
    end

    it 'should request application about items' do
      expect(@matcher).to receive(:applicable_for?).with(@filtered)
      @rule.apply(@items)
    end
  end
end