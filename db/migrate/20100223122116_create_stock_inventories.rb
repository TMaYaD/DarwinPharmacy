class CreateStockInventories < ActiveRecord::Migration
  def self.up
    create_table :stock_inventories do |t|
      t.references :franchise
      t.references :product_batch
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :stock_inventories
  end
end
