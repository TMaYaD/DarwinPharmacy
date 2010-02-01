class Product < ActiveRecord::Base
  DOSAGE_FORMS = %w[Ampoule Capsule Cream Drops Gel Gelly Granules Injection Inhaler Liquid Lotion Ointment Powder Sachet Soap Suspension Spray Syrup Tablet]

  validates_presence_of :name, :manufacturer, :dosage_form 
  validates_uniqueness_of :name
  validates_inclusion_of :dosage_form, :in => DOSAGE_FORMS
end
