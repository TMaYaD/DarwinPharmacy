class SaleBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :sale_bill
  belongs_to :product_batch
  include ProductBatch::AutocompleteFields

  before_create :transfer_stock_inventory

  validates_presence_of :product_batch_id, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0

  def amount
    self.quantity * self.product_batch.rate
  end

  def tax_add (visitor)
    vat_slab = self.product_batch.vat
    visitor[vat_slab] ||= {:amount => 0, :tax => 0}
    visitor[vat_slab][:tax]  += (self.amount * vat_slab).floor / 100
    visitor[vat_slab][:amount]  += self.amount
    return visitor
  end

  private
  def transfer_stock_inventory
    source_store_id = 7 #Franchise.find_by_name("DPPL - Vijayawada")
    destination_store_id = self.sale_bill.franchise.id
    StockInventory.find_by_product_batch_id_and_franchise_id(self.product_batch.id, source_store_id).
        decrement(:quantity, self.quantity * self.product_batch.pack).save &&
    StockInventory.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch.id, destination_store_id).
        increment(:quantity, self.quantity * self.product_batch.pack).save
  end
end
