module Discounts
  class DiscountedProduct
    extend Forwardable

    attr_reader :product, :price
    delegate [:code, :has_code?] => :product

    def initialize(product)
      @product, @price = product, product.price
    end

    def add_discount_percent(percent)
      update_price(price - price * percent / 100.0)
    end

    def add_discount_amount(amount)
      update_price(price - amount)
    end

    def update_price(price)
      return 0 if price < 0
      @price = price.round(2)
    end
  end
end