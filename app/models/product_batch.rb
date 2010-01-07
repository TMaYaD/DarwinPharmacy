class ProductBatch < ActiveRecord::Base
  belongs_to :product

  validates_presence_of :product_id, :batch_code, :mfg_date, :exp_date, :price
  validates_numericality_of :price, :greater_than => 0
  validates_uniqueness_of :batch_code, :scope => :product_id

  def to_label
    self.product.name + ':' + self.batch_code
  end
end
