class Franchise < ActiveRecord::Base
  has_and_belongs_to_many :users
  belongs_to :franchisee, :class_name => "User"
end
