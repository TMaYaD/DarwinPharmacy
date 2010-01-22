class CreateSaleBills < ActiveRecord::Migration
  def self.up
    create_table :sale_bills do |t|
      t.references :franchise
      t.references :created_by
      t.references :modified_by

      t.timestamps
    end
  end

  def self.down
    drop_table :sale_bills
  end
end
