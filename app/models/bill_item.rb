class BillItem < ActiveRecord::Base
  belongs_to :bill
  belongs_to :product_batch

  #validates_presence_of :bill_id, :product_batch_id
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0
  validates_numericality_of :discount, :less_than => 15

  def amount
    self.product_batch.mrp * self.quantity / self.product_batch.pack * (100 - self.discount) /100
  end

  def product_name
    self.product_batch.product_name if self.product_batch
  end
  def product_name=(name)
    @product_name = name
  end

  def product_batch_code
    self.product_batch.batch_code if self.product_batch
  end
  def product_batch_code=(code)
    self.product_batch = ProductBatch.find_by_batch_code(code,
      :conditions => ['products.name like ?', "%#{@product_name}%" ],
      :joins => :product
    ) unless code.blank?
  end
end
