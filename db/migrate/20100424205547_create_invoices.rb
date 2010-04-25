class CreateInvoices < ActiveRecord::Migration
  def self.up
    create_table :invoices do |t|
      t.string :invoice_number
      t.references :store
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :invoices
  end
end
