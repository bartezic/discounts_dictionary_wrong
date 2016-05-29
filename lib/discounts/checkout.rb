require_relative 'product_catalog'

module Discounts
  class Checkout
    attr_reader :rules, :cart

    def initialize(*rules)
      @rules, @cart = rules, []
    end

    def scan(code)
      cart << DiscountedProduct.new(ProductCatalog.item_by_code(code))
    end

    def total
      apply_discounts
      cart.map(&:price).reduce(0, :+).round(2)
    end

    protected
    def apply_discounts
      rules.each { |rule| rule.apply(cart) }
    end
  end
end