class AddMrpToBillItem < ActiveRecord::Migration
  def self.up
    add_column :bill_items, :mrp, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    remove_column :bill_items, :mrp
  end
end
