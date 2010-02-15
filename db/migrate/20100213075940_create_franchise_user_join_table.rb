class CreateFranchiseUserJoinTable < ActiveRecord::Migration
  def self.up
    create_table :franchises_users, :id => false do |t|
      t.references :franchise
      t.references :user
    end
  end

  def self.down
    drop_table :franchises_users
  end
end
