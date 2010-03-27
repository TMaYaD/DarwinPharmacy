class CreatePurchaseRequests < ActiveRecord::Migration
  def self.up
    create_table :purchase_requests do |t|
      t.references :product
      t.integer :quantity
      t.references :franchise

      t.timestamps
    end
  end

  def self.down
    drop_table :purchase_requests 
  end
end
