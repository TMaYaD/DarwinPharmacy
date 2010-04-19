class RenameFranchiseToStore < ActiveRecord::Migration
  def self.up
    rename_table :franchises, :stores
    rename_table :franchises_users, :stores_users
    rename_column :bills, :franchise_id, :store_id
    rename_column :stores_users, :franchise_id, :store_id
    rename_column :purchase_requests, :franchise_id, :store_id
    rename_column :sale_bills, :franchise_id, :store_id
    rename_column :stock_inventories, :franchise_id, :store_id
  end

  def self.down
    rename_column :stock_inventories, :store_id, :franchise_id
    rename_column :sale_bills, :store_id, :franchise_id
    rename_column :purchase_requests, :store_id, :franchise_id
    rename_column :stores_users, :store_id, :franchise_id
    rename_column :bills, :store_id, :franchise_id
    rename_table :stores_users, :franchises_users
    rename_table :stores, :franchises
  end
end
