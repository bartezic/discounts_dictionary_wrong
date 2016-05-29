require_relative 'abstract'

module Discounts
  module Pricing
    class Percent < Abstract
      attr_reader :discount_percent

      def initialize(discount_percent)
        @discount_percent = discount_percent
      end

      def apply(items)
        items.each {|item| item.add_discount_percent(discount_percent)}
      end
    end
  end
end