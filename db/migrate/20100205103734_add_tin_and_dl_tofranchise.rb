class AddTinAndDlTofranchise < ActiveRecord::Migration
  def self.up
    add_column :franchises, :dl, :string
    add_column :franchises, :tin, :string
  end

  def self.down
    remove_column :franchises, :tin
    remove_column :franchises, :dl
  end
end
