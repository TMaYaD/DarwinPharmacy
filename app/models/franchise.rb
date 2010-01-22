class Franchise < ActiveRecord::Base
  belongs_to :franchisee, :class_name => 'User'
end
