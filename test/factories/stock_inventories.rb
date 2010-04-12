Factory.define :stock_inventory do |s|
  s.association :product_batch
  s.quantity 10
  s.association :franchise
end
