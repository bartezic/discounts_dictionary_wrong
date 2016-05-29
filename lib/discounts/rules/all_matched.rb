require_relative 'abstract'

module Discounts
  module Rules
    class AllMatched < Abstract
      def apply_discount(items)
        pricing.apply(matcher.filter_matched_items(items))
      end
    end
  end
end