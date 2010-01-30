Factory.define :purchase_bill do |b|
  b.sequence (:supplier_name) {|n| "purchase_bill_supplier_#{n}"}
  b.due_date Date.today
  b.bill_number '245'
  b.sequence(:purchase_bill_items_attributes) {|n| { n => Factory(:purchase_bill_item)}}
end
