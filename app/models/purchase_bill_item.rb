class PurchaseBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :purchase_bill
  belongs_to :product_batch

  after_create :increment_stock_inventory

  validates_associated :product_batch
  #validates_presence_of :purchase_bill_id, :product_batch_id
  validates_presence_of :sale_quantity
  validates_numericality_of :sale_quantity, :greater_than => 0
  validates_numericality_of :free_quantity
  validates_numericality_of :discount, :less_than => 100

  accepts_nested_attributes_for :product_batch

  def amount
    (sale_quantity * product_batch.rate * ( 100 - discount )).round / 100 
  end

  def tax_add (visitor)
    vat_slab = self.product_batch.vat
    visitor[vat_slab] ||= {:amount => 0, :tax => 0}
    visitor[vat_slab][:tax]  += (self.amount * vat_slab).floor / 100
    visitor[vat_slab][:amount]  += self.amount
    return visitor
  end

  private
  def increment_stock_inventory
    franchise_id = 7 #Franchise.find_by_name("DPPL - Vijayawada")
    unless StockInventory.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch.id, franchise_id).increment(:quantity, (self.sale_quantity + self.free_quantity)*self.product_batch.pack).save
      raise ActiveRecord::Rollback
    end
  end
end
