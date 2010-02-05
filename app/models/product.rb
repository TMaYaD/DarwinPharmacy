class Product < ActiveRecord::Base
  DOSAGE_FORMS = %w[Ampoule Capsule Cream Drops Gel Gelly Granules Injection Inhaler Liquid Lotion Ointment Powder Sachet Soap Suspension Spray Syrup Tablet]

  validates_presence_of :name, :manufacturer, :dosage_form 
  validates_uniqueness_of :name
  validates_inclusion_of :dosage_form, :in => DOSAGE_FORMS

  module AutocompleteFields
    def product_name
      return self.product.name if self.respond_to?(:product) && self.product
      return self.product_batch.product_name if self.respond_to?(:product_batch) && self.product_batch
    end
    def product_name=(name)
      @product_name = name
    end
  end
end
