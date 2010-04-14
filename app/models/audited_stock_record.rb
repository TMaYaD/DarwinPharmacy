class AuditedStockRecord < StockInventory
  after_save :update_running_stock_record
  before_validation :set_franchise_and_date

  validates_presence_of :product_batch_id, :franchise_id, :quantity
 
  include ProductBatch::AutocompleteFields

private
  def update_running_stock_record
    running_stock_record = RunningStockRecord.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch_id, self.franchise_id)
    running_stock_record.quantity = self.quantity
    running_stock_record.save
  end

  def set_franchise_and_date
    self.franchise_id ||= 3 # Suryarao Pet
  end
end
