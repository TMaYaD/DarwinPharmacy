class PurchaseBillItem < ActiveRecord::Base
  belongs_to :purchase_bill
  belongs_to :product_batch


  validates_associated :product_batch
  #validates_presence_of :purchase_bill_id, :product_batch_id
  validates_presence_of :sale_quantity
  validates_numericality_of :sale_quantity, :greater_than => 0
  validates_numericality_of :free_quantity
  validates_numericality_of :discount, :less_than => 100

  accepts_nested_attributes_for :product_batch

  def amount
    sale_quantity * product_batch.rate * ( 1 - discount/100 )
  end

  def vat_amount
    amount * product_batch.vat / 100
  end
end
