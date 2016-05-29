require_relative 'product'

module Discounts
  class ProductCatalog
    PRODUCT_PRICES = {'FR' => 3.11, 'SR' => 5.0, 'CF' => 11.23}

    def self.item_by_code(code)
      raise "unknown product code #{code}" unless PRODUCT_PRICES[code]
      Discounts::Product.new(code, PRODUCT_PRICES[code])
    end
  end
end