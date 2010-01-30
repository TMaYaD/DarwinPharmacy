Factory.define :sale_bill_item, :default_strategy => :attributes_for do |p|
  p.association :product_batch
  p.quantity 7
end
