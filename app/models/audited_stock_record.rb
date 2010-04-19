class AuditedStockRecord < StockInventory
  after_save :update_running_stock_record
  before_validation :set_store_and_date

  validates_presence_of :product_batch_id, :store_id, :quantity
 
  include ProductBatch::AutocompleteFields

private
  def update_running_stock_record
    running_stock_record = RunningStockRecord.find_or_initialize_by_product_batch_id_and_store_id(self.product_batch_id, self.store_id)
    running_stock_record.quantity = self.quantity
    running_stock_record.save
  end

  def set_store_and_date
    self.store_id ||= Authorization.current_user.stores[0]
  end
end
