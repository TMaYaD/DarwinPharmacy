class BillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :bill
  belongs_to :product_batch
  include ProductBatch::AutocompleteFields

  before_create :decrement_stock_record

  validates_presence_of :product_batch_id
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :less_than => 16
  validate :has_stock_record

  def amount
    (self.product_batch.mrp * self.quantity / self.product_batch.pack * (100 - self.discount)).ceil / 100
  end

  def savings
    (self.product_batch.mrp * self.quantity / self.product_batch.pack * self.discount).ceil / 100
  end

  private
  def has_stock_record
    store_id = self.bill && self.bill.franchise_id || Authorization.current_user.franchises[0].id
    errors.add(:product_batch_code, "stock not available") unless RunningStockRecord.find_by_product_batch_id_and_franchise_id(self.product_batch.id, store_id)
  end
  def decrement_stock_record
    store_id = self.bill.franchise.id
    RunningStockRecord.find_by_product_batch_id_and_franchise_id(self.product_batch.id, store_id).decrement(:quantity, self.quantity).save
  end
end
