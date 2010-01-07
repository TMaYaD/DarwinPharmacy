class Product < ActiveRecord::Base
  DOSAGE_FORMS = %w[Ampoule Capsule Cream Drops Gel Granules Injection Inhaler Liquid Lotion Ointment Powder Suspension Spray Syrup Tablets]

  validates_presence_of :name, :manufacturer, :composition, :dosage_form, :strength
  validates_uniqueness_of :name
  validates_inclusion_of :dosage_form, :in => DOSAGE_FORMS
end
