Factory.define :invoice_item do |i|
  i.association :invoice
  i.association :product_batch
  i.sale_quantity '10'
  i.free_quantity '2'
  i.discount '8'
  i.rate '12.5'
  i.vat '4'
end

