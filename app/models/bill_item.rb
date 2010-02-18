class BillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :bill
  belongs_to :product_batch
  include ProductBatch::AutocompleteFields

  validates_presence_of :product_batch_id
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :less_than => 16

  def amount
    (self.product_batch.mrp * self.quantity / self.product_batch.pack * (100 - self.discount)).ceil / 100
  end

  def savings
    (self.product_batch.mrp * self.quantity / self.product_batch.pack * self.discount).ceil / 100
  end
end
