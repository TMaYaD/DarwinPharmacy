class InvoiceItem < ActiveRecord::Base
  attr_accessible :invoice, :product_batch, :sale_quantity, :free_quantity, :discount, :rate, :vat
end
