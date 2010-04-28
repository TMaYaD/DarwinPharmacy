class InvoiceItem < ActiveRecord::Base
  attr_accessible :invoice_id, :product_batch_id, :sale_quantity, :free_quantity, :discount, :rate, :vat

  belongs_to :invoice
  belongs_to :product_batch

  validates_numericality_of :sale_quantity, :greater_than_or_equal_to => 0
  validates_presence_of :product_batch_id

  def amount
    (((sale_quantity * rate) * (100 - discount) / 100) * (100 + vat)).round / 100
  end
end
