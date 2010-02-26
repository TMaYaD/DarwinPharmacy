class PurchaseBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :purchase_bill
  belongs_to :product_batch


  validates_associated :product_batch
  validates_presence_of :sale_quantity
  validates_numericality_of :sale_quantity, :greater_than => 0
  validates_numericality_of :free_quantity
  validates_numericality_of :discount, :less_than => 100

  after_validation { |item|
    item.product_batch = ProductBatch.find(self.product_batch.id) if self.product_batch.id
  }

  accepts_nested_attributes_for :product_batch

  def amount
    (sale_quantity * product_batch.rate * ( 100 - discount )).round / 100 
  end

  def tax_add (visitor)
    vat_slab = self.product_batch.vat
    visitor[vat_slab] ||= {:amount => 0, :tax => 0}
    visitor[vat_slab][:tax]  += (self.amount * vat_slab).floor / 100
    visitor[vat_slab][:amount]  += self.amount
    return visitor
  end
end
