class RemoveCreatedAndModifiedByColumns < ActiveRecord::Migration
  def self.up
    remove_columns :bills, :created_by_id, :modified_by_id
    remove_columns :purchase_bills, :created_by_id, :modified_by_id
    remove_columns :sale_bills, :created_by_id, :modified_by_id
  end

  def self.down
    add_column(:bills, :created_by_id, :integer)
    add_column(:bills, :modified_by_id, :integer)
    add_column(:sale_bills, :created_by_id, :integer)
    add_column(:sale_bills, :modified_by_id, :integer)
    add_column(:purchase_bills, :created_by_id, :integer)
    add_column(:purchase_bills, :modified_by_id, :integer)
  end
end
