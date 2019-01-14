class OrderDecorator < ApplicationDecorator
  def total_price
    items.inject(0) {|total_price, item| total_price + item.price}
  end
end
