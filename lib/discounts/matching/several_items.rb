require_relative 'collection'

module Discounts
  module Matching
    class SeveralItems < Collection
      def initialize(code, count)
        super(count.times.map { code })
      end
    end
  end
end