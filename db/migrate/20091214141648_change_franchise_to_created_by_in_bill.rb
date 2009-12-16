class ChangeFranchiseToCreatedByInBill < ActiveRecord::Migration
  def self.up
    change_table :bills do |t|
      t.rename :franchise_id, :created_by_id
      t.string :modified_by_id
    end
  end

  def self.down
    change_table :bills do |t|
      t.remove :modified_by_id
      t.rename :created_by_id, :franchise_id
    end
  end
end
