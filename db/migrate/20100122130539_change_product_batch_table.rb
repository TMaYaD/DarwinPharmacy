class ChangeProductBatchTable < ActiveRecord::Migration
  def self.up
    change_table :product_batches do |t|
      t.rename :price, :mrp
      t.decimal :vat, :precision => 4, :scale => 2
      t.decimal :rate, :precision => 8, :scale => 2
    end
    change_table :purchase_bill_items do |t|
      t.remove :vat
      t.remove :rate
    end
  end

  def self.down
    change_table :purchase_bill_items do |t|
      t.decimal :rate, :precision => 8, :scale => 2
      t.decimal :vat, :precision => 4, :scale => 2
    end
    change_table :product_batches do |t|
      t.remove :rate
      t.remove :vat
      t.rename :mrp, :price
    end
  end
end
