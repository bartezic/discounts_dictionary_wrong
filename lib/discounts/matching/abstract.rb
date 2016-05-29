module Discounts
  module Matching
    class Abstract
      # is items match required criteria for discount
      def applicable_for?(items)
        false
      end

      # get first items which match criteria
      def extract_matched_items(items)
        []
      end

      # get all items which match criteria
      def filter_matched_items(items)
        []
      end

      protected
      def pop_item(items, code)
        return unless (index = items.index { |item| item.has_code?(code) })
        items.delete_at(index)
      end
    end
  end
end