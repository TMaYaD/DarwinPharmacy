Factory.define :sale_bill do |b|
  b.association :franchise
  b.sequence(:sale_bill_items_attributes) {|n| { n => Factory(:sale_bill_item, :product_batch_id => Factory(:product_batch).to_param) } }
end
