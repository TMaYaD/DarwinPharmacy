class SaleBillItem < ActiveRecord::Base
  belongs_to :sale_bill
  belongs_to :product_batch

  validates_presence_of :product_batch_id, :quantity
  validates_numericality_of :quantity, :only_integer => true, :greater_than => 0

  def product_batch_code
    product_batch.batch_code if product_batch
  end
  def product_batch_code=(code)
    self.product_batch = ProductBatch.find_by_batch_code(code,
      :conditions => ['products.name like ?', "%#{@product_name}%" ],
      :joins => :product,
    ) unless code.blank?
  end

  def product_name
    @product_name
  end
  def product_name=(name)
    @product_name = name
  end
end
