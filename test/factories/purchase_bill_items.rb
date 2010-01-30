Factory.define :purchase_bill_item, :default_strategy => :attributes_for do |p|
  p.product_batch_attributes {Factory.attributes_for(:product_batch, :product_name => Factory(:product).name )}
  p.sale_quantity 7
  p.free_quantity 1
  p.discount 10
end
