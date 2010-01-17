class CreatePurchaseBills < ActiveRecord::Migration
  def self.up
    create_table :purchase_bills do |t|
      t.string :bill_number
      t.references :supplier
      t.date :due_date
      t.references :created_by
      t.references :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_bills
  end
end
