class AddTypeToStockInventory < ActiveRecord::Migration
  def self.up
    add_column :stock_inventories, :type, :string, :default => "RunningStockRecord"
  end

  def self.down
    remove_column :stock_inventories, :type
  end
end
