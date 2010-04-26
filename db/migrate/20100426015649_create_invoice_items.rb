class CreateInvoiceItems < ActiveRecord::Migration
  def self.up
    create_table :invoice_items do |t|
      t.references :invoice
      t.references :product_batch
      t.decimal :sale_quantity, :precision => 6,  :scale => 1
      t.decimal :free_quantity, :precision => 6,  :scale => 1
      t.decimal :discount, :precision => 4,  :scale => 2
      t.decimal :rate, :precision => 8,  :scale => 2
      t.decimal :vat, :precision => 4,  :scale => 2
      t.timestamps
    end
  end
  
  def self.down
    drop_table :invoice_items
  end
end
