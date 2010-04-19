class StockInventory < ActiveRecord::Base
  belongs_to :store
  belongs_to :product_batch
end
