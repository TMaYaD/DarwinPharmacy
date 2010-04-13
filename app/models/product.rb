class Product < ActiveRecord::Base
  acts_as_audited

  DOSAGE_FORMS = %w[Ampoule Capsule Cream Drops Gel Gelly Granules Injection Inhaler Liquid Lotion Ointment Powder Sachet Soap Suspension Spray Suppositories Syrup Tablet Suture Fluid Disposable Biscuits Shampoo]

  validates_presence_of :name, :manufacturer, :dosage_form 
  validates_uniqueness_of :strength, :scope => :name
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
