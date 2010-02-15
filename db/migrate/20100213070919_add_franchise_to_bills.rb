class AddFranchiseToBills < ActiveRecord::Migration
  def self.up
    add_column :bills, :franchise_id, :integer
  end

  def self.down
    remove_column :bills, :franchise_id
  end
end
