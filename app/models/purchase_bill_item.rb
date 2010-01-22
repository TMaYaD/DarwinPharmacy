class PurchaseBillItem < ActiveRecord::Base
  belongs_to :purchase_bill
  belongs_to :product_batch

  VATS = [4, 12.5, 14.5]

  validates_associated :product_batch
  #validates_presence_of :purchase_bill_id, :product_batch_id
  validates_presence_of :sale_quantity, :rate
  validates_numericality_of :sale_quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :free_quantity, :only_integer => true
  validates_numericality_of :discount, :less_than => 100
  validates_numericality_of :rate
  validates_inclusion_of :vat, :in => VATS

  accepts_nested_attributes_for :product_batch, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
end
