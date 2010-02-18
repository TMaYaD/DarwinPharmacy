class ChangeColumnTypesForPhone < ActiveRecord::Migration
  def self.up
    change_column :customers, :phone, :string
    change_column :users, :phone, :string
  end

  def self.down
    change_column :users, :phone, :integer
    change_column :customers, :phone, :integer
  end
end
