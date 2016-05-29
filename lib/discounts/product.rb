module Discounts
  class Product
    attr_reader :code, :price

    def initialize(code, price)
      @code, @price = code, price
    end

    def has_code?(code)
      @code == code
    end

    def ==(other)
      return false unless other.is_a?(Discounts::Product)
      other.code == code
    end
  end
end