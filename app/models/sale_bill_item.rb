class SaleBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :sale_bill
  belongs_to :product_batch
  include ProductBatch::AutocompleteFields

  validates_presence_of :product_batch_id, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0

  def amount
    (self.quantity * self.product_batch.rate * (self.product_batch.vat + 100)).round / 100
  end

  def tax_add (visitor)
    vat_slab = self.product_batch.vat
    visitor[vat_slab] ||= {:amount => 0, :tax => 0}
    visitor[vat_slab][:tax]  += (self.amount * vat_slab).floor / 100
    visitor[vat_slab][:amount]  += self.amount
    return visitor
  end
end
