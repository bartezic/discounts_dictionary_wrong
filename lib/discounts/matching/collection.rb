require_relative 'abstract'

module Discounts
  module Matching
    class Collection < Abstract
      attr_reader :codes

      def initialize(items_codes)
        @codes = items_codes
      end

      def applicable_for?(items)
        items_codes = items.map(&:code)
        codes.all? { |code| codes.count(code) <= items_codes.count(code) }
      end

      def extract_matched_items(items)
        codes.map { |code| pop_item(items, code) }.compact
      end

      def filter_matched_items(items)
        items.select { |item| codes.include?(item.code) }
      end
    end
  end
end