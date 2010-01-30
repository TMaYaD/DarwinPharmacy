class AddPackToProductBatches < ActiveRecord::Migration
  def self.up
    add_column :product_batches, :pack, :integer
  end

  def self.down
    remove_column :product_batches, :pack
  end
end
