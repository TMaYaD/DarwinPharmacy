class Customer < ActiveRecord::Base
  validates_presence_of :name, :phone, :address
  validates_numericality_of :phone, :only_integer => true, :greater_than => 1000000000, :less_than => 9999999999
  validates_uniqueness_of :phone
  validates_length_of :name, :minimum => 5
  validates_length_of :address, :minimum => 15
end
