class SaleBillItem < ActiveRecord::Base
  belongs_to :sale_bill
  belongs_to :product_batch

  validates_presence_of :product_batch_id, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
end
