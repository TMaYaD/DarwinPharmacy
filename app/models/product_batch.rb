class ProductBatch < ActiveRecord::Base
  acts_as_audited

  belongs_to :product
  include Product::AutocompleteFields

  VATS = [0, 4, 12.5, 14.5]

  validates_presence_of :product_id, :batch_code, :exp_date, :mrp, :rate, :vat
  # validates_presence_of :mfg_date 
  validates_numericality_of :mrp, :rate, :greater_than => 0
  validates_numericality_of :pack, :only_integer => true, :greater_than => 0
  #validates_uniqueness_of :batch_code, :scope => :product_id # need this temporarily for the bug in purchase bills.
  validate :exp_date_cannot_be_in_the_past
  # :exp_date_cannot_be_earlier_than_mfg_date,
  # :mfg_date_cannot_be_in_the_future
  # :has_profit
  validates_inclusion_of :vat, :in => VATS

  module AutocompleteFields
    include Product::AutocompleteFields

    def product_id
      self.product_batch.product_id if self.product_batch
    end
    def product_id=(id)
      @product_id = id
    end

    def product_batch_code
      self.product_batch.batch_code if self.product_batch
    end
    def product_batch_code=(code)
      @product_batch_code = code
    end
  end

  private
  def exp_date_cannot_be_in_the_past
    errors.add(:exp_date, "can't be in the past") if  !exp_date.blank? and exp_date < Date.today
  end

#  def mfg_date_cannot_be_in_the_future
#    errors.add(:mfg_date, "can't be in the future") if  !mfg_date.blank? and mfg_date > Date.today
#  end

#  def exp_date_cannot_be_earlier_than_mfg_date
#    errors.add(:exp_date, "can't be earlier than the Manufacturing Date") if  !exp_date.blank? and !mfg_date.blank? and exp_date < mfg_date
#  end

end
