class ChangeQuantitiesInPurchaseBillItemsToDecimals < ActiveRecord::Migration
  def self.up
    change_column :purchase_bill_items, :sale_quantity, :decimal, :precision => 8, :scale => 2
    change_column :purchase_bill_items, :free_quantity, :decimal, :precision => 8, :scale => 2
  end

  def self.down
    change_column :purchase_bill_items, :free_quantity, :integer
    change_column :purchase_bill_items, :sale_quantity, :integer
  end
end
