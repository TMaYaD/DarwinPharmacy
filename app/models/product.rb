class Product < ActiveRecord::Base
  validates_presence_of :name, :manufacturer, :schedule, :composition, :dosage_form, :strength
  validates_uniqueness_of :name
end
