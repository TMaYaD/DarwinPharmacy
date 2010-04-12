class AuditedStockRecord < StockInventory
  after_save :update_running_stock_record

private
  def update_running_stock_record
    running_stock_record = RunningStockRecord.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch_id, self.franchise_id)
    running_stock_record.quantity = self.quantity
    running_stock_record.save
  end
end
