class StockInventory < ActiveRecord::Base
  belongs_to :franchise
  belongs_to :product_batch
end
