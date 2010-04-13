class SaleBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :sale_bill
  belongs_to :product_batch
  include ProductBatch::AutocompleteFields

  before_create :transfer_stock_record
  before_validation :get_rate_and_vat_from_product_batch

  validates_presence_of :product_batch_id, :quantity, :rate, :vat
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validate :has_stock_record

  def amount
    self.quantity * self.rate
  end

  def net_amount
    (self.amount * (self.vat + 100)).round / 100
  end

  private
  def get_rate_and_vat_from_product_batch
    self.rate ||= self.product_batch.rate
    self.vat ||= self.product_batch.vat
  end

  def has_stock_record
    errors.add(:product_batch_code, "doesn't have a stock record") unless RunningStockRecord.find_by_product_batch_id_and_franchise_id(self.product_batch.id, Franchise.find_by_name("DPPL - Vijayawada").id)
  end

  def transfer_stock_record
    source_store_id = Franchise.find_by_name("DPPL - Vijayawada").id
    destination_store_id = self.sale_bill.franchise.id
    RunningStockRecord.find_by_product_batch_id_and_franchise_id(self.product_batch.id, source_store_id).
        decrement(:quantity, self.quantity * self.product_batch.pack).save &&
    RunningStockRecord.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch.id, destination_store_id).
        increment(:quantity, self.quantity * self.product_batch.pack).save
  end
end
