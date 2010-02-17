class Product < ActiveRecord::Base
  DOSAGE_FORMS = %w[Ampoule Capsule Cream Drops Gel Gelly Granules Injection Inhaler Liquid Lotion Ointment Powder Sachet Soap Suspension Spray Syrup Tablet Suppositories]

  validates_presence_of :name, :manufacturer, :dosage_form 
  validates_uniqueness_of :name
  validates_inclusion_of :dosage_form, :in => DOSAGE_FORMS

  def to_label
      "#{self.name} : #{self.dosage_form} : #{self.strength || ''}"
  end

  module AutocompleteFields
    def product_name
      product = self.product if self.respond_to?(:product) && self.product
      product = self.product_batch.product if self.respond_to?(:product_batch) && self.product_batch
      product.to_label if product
    end
    def product_name=(name)
      @product_name = name
    end
  end
end
