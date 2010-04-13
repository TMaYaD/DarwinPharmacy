Factory.define :purchase_bill do |b|
  b.sequence(:supplier_name) {|n| "purchase_bill_supplier_#{n}"}
  b.due_date Date.today
  b.bill_number '245'
  b.sequence(:purchase_bill_items_attributes) {|n| { n => Factory(:purchase_bill_item)}}
end

Factory.define :purchase_bill_item, :default_strategy => :attributes_for do |p|
  p.product_batch_attributes {Factory.attributes_for(:product_batch, :product => Factory(:product))}
  p.sale_quantity 7
  p.free_quantity 1
  p.discount 10
  p.rate 12.3
  p.vat 4
end
