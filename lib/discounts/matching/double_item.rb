require_relative 'collection'

module Discounts
  module Matching
    class DoubleItem < Collection
      def initialize(code)
        super([code, code])
      end
    end
  end
end