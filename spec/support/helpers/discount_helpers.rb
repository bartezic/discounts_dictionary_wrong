require 'discounts/product'
require 'discounts/discounted_product'

def products_list(codes, prices = [])
  codes.map.with_index { |code, index| product(code, prices[index]) }
end

def product(code, price = nil)
  Discounts::Product.new(code, price || 1)
end

def discounted_product(code, price)
  Discounts::DiscountedProduct.new(product(code, price))
end