class CreatePurchaseBillItems < ActiveRecord::Migration
  def self.up
    create_table :purchase_bill_items do |t|
      t.references :purchase_bill
      t.references :product_batch
      t.integer :sale_quantity
      t.integer :free_quantity
      t.decimal :discount, :precision => 4, :scale => 2
      t.decimal :rate, :precision => 8, :scale => 2
      t.decimal :vat, :precision => 4, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_bill_items
  end
end
