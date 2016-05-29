require_relative 'abstract'

module Discounts
  module Pricing
    class DiscountsSequence < Abstract
      attr_reader :discounts_sequence

      def initialize(*discounts_sequence)
        @discounts_sequence = discounts_sequence
      end

      def apply(items)
        items.each.with_index do |item, index|
          item.add_discount_percent(discounts_sequence[index] || 0)
        end
      end
    end
  end
end