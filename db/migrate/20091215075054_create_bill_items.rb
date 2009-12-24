class CreateBillItems < ActiveRecord::Migration
  def self.up
    create_table :bill_items do |t|
      t.references :bill
      t.references :product_batch
      t.integer :quantity
      t.decimal :discount, :precision => 4, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :bill_items
  end
end
