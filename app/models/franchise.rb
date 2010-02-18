class Franchise < ActiveRecord::Base
  acts_as_audited

  has_and_belongs_to_many :users
  belongs_to :franchisee, :class_name => "User"
end
