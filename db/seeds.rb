10.times do
  Item.create name: FFaker::Product.product_name, price: rand(1000)
end

10.times do
  order = Order.create token: SecureRandom.hex.last(10)
  3.times do
    order.items << Item.all.to_a.sample
  end
end
