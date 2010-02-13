class AddFranchiseToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :franchise, :references
  end

  def self.down
    remove_column :bills, :franchise
  end
end
