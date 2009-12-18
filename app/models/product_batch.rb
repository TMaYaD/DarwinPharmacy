class ProductBatch < ActiveRecord::Base
  belongs_to :product

  def to_label
    self.product.name + ':' + self.batch_code
  end
end