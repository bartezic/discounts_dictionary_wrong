require_relative 'abstract'

module Discounts
  module Rules
    class ItemsPack < Abstract
      def apply_discount(items)
        filtered_items = matcher.filter_matched_items(items)
        while matcher.applicable_for?(filtered_items)
          selected_items = matcher.extract_matched_items(filtered_items)
          pricing.apply(selected_items)
        end
      end

      def print(items)
        items.map(&:code).inspect
      end
    end
  end
end