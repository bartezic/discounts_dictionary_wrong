module Discounts
  module Rules
    class Abstract
      attr_reader :matcher, :pricing
      def initialize(matcher, pricing)
        @matcher, @pricing = matcher, pricing
      end

      def apply(items)
        return unless matcher.applicable_for?(items)
        apply_discount(items)
      end

      protected
      def apply_discount(items)
        # no discount in abstract rule
      end
    end
  end
end