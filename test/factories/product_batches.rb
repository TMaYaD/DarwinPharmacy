Factory.define :product_batch do |p|
  p.association :product
  p.sequence(:batch_code) {|n| "code_#{n}"}
  p.pack 1
  p.exp_date Date.today>>12
  p.mrp 72.43
  p.rate 24.54
  p.vat 4
end
