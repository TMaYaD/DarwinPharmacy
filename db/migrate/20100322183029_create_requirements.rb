class CreateRequirements < ActiveRecord::Migration
  def self.up
    create_table :requirements do |t|
      t.references :product
      t.integer :quantity
      t.references :franchise

      t.timestamps
    end
  end

  def self.down
    drop_table :requirements
  end
end
