class AddMrpRateVatAndPackToProduct < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.decimal  "mrp",        :precision => 8, :scale => 2
      t.decimal  "vat",        :precision => 4, :scale => 2
      t.decimal  "rate",       :precision => 8, :scale => 2
      t.integer  "pack"
    end
  end

  def self.down
    change_table :products do |t|
      t.remove :pack
      t.remove :vat
      t.remove :rate
      t.remove :mrp
    end
  end
end
