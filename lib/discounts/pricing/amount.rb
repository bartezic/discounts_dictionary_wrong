require_relative 'abstract'

module Discounts
  module Pricing
    class Amount < Abstract
      attr_reader :discount

      def initialize(discount)
        @discount = discount
      end

      def apply(items)
        items.each {|item| item.add_discount_amount(discount)}
      end
    end
  end
end