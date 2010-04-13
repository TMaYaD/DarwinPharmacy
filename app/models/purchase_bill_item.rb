class PurchaseBillItem < ActiveRecord::Base
  acts_as_audited

  belongs_to :purchase_bill
  belongs_to :product_batch

  after_create :increment_stock_record

  validates_associated :product_batch
  validates_presence_of :sale_quantity
  validates_numericality_of :sale_quantity, :greater_than => 0
  validates_numericality_of :free_quantity
  validates_numericality_of :discount, :less_than => 100

  after_validation :find_product_batch_if_existing
  after_save :update_rate_and_vat_for_the_product_batch

  accepts_nested_attributes_for :product_batch

  def amount
    (sale_quantity * rate * ( 100 - discount )).round / 100 
  end

  def net_amount
    (self.amount * (self.vat + 100)).round / 100
  end

  def tax_add (visitor)
    visitor[self.vat] ||= {:amount => 0, :tax => 0}
    visitor[self.vat][:tax]  += (self.amount * self.vat).floor / 100
    visitor[self.vat][:amount]  += self.amount
    return visitor
  end

  private
  def find_product_batch_if_existing
    self.product_batch = ProductBatch.find(self.product_batch.id) if self.product_batch.id
  end
  def increment_stock_record
    franchise_id = Franchise.find_by_name("DPPL - Vijayawada").id
    unless RunningStockRecord.find_or_initialize_by_product_batch_id_and_franchise_id(self.product_batch.id, franchise_id).increment(:quantity, (self.sale_quantity + self.free_quantity)*self.product_batch.pack).save
      raise ActiveRecord::Rollback
    end
  end
  def update_rate_and_vat_for_the_product_batch
    self.product_batch.vat ||= self.vat
    self.product_batch.rate ||= self.rate
    self.product_batch.save
  end
end
