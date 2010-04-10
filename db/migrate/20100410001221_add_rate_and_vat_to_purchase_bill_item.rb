class AddRateAndVatToPurchaseBillItem < ActiveRecord::Migration
  def self.up
    add_column :purchase_bill_items, :rate, :decimal, :precision => 8, :scale => 2
    add_column :purchase_bill_items, :vat, :decimal, :precision => 4, :scale => 2
  end

  def self.down
    remove_column :purchase_bill_items, :vat
    remove_column :purchase_bill_items, :rate
  end
end
