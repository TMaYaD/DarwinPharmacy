class CreateProducts < ActiveRecord::Migration
  def self.up
    create_table :products do |t|
      t.string :name
      t.string :manufacturer
      t.string :category
      t.text :composition
      t.string :dosage
      t.string :strength
      t.text :common_uses

      t.timestamps
    end
  end

  def self.down
    drop_table :products
  end
end
