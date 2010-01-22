class CreateSaleBillItems < ActiveRecord::Migration
  def self.up
    create_table :sale_bill_items do |t|
      t.references :sale_bill
      t.references :product_batch
      t.integer :quantity

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_bill_items
  end
end
