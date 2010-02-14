Factory.define :bill do |b|
  b.association :customer
  b.sequence(:bill_items_attributes) {|n| { n => Factory(:bill_item, :product_batch_id => Factory(:product_batch).to_param) }}
end
