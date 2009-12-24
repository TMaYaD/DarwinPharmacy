class CreateProductBatches < ActiveRecord::Migration
  def self.up
    create_table :product_batches do |t|
      t.references :product
      t.string :batch_code
      t.date :mfg_date
      t.date :exp_date
      t.decimal :price, :precision => 8, :scale => 2

      t.timestamps
    end
  end

  def self.down
    drop_table :product_batches
  end
end
