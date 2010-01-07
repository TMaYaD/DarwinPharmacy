class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :product_batch

  validates_presence_of :bill_id, :product_batch_id, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :less_than => 100

  def price
    self.product_batch.price * self.quantity * (100 - self.discount) /100
  end
end
