class ProductBatch < ActiveRecord::Base
  acts_as_audited

  belongs_to :product
  include Product::AutocompleteFields

  VATS = [0, 4, 12.5, 14.5]

  validates_presence_of :product_id, :batch_code, :exp_date, :mrp, :rate, :vat
  # validates_presence_of :mfg_date 
  validates_numericality_of :mrp, :rate, :greater_than => 0
  validates_numericality_of :pack, :only_integer => true, :greater_than => 0
  validate :uniqueness_of_batch_code
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

  def uniqueness_of_batch_code
    existing = ProductBatch.find_by_batch_code_and_product_id(self.batch_code, self.product_id)
    if existing
    then
      self.errors.add(:pack, "doesn't match with stored value :#{existing.pack}") if self.pack == existing.pack
      self.errors.add(:exp_date, "doesn't match with stored value :#{existing.exp_date}") if self.exp_date == existing.exp_date
      self.errors.add(:rate, "doesn't match with stored value :#{existing.rate}") if self.rate == existing.rate
      self.errors.add(:mrp, "doesn't match with stored value :#{existing.mrp}") if self.mrp == existing.mrp
      self.errors.add(:vat, "doesn't match with stored value :#{existing.vat}") if self.vat == existing.vat
      if errors.size == 0
      then
        self.id = existing.id
      else
        self.errors.add( :phone, :taken)
      end
    end
  end
#  def mfg_date_cannot_be_in_the_future
#    errors.add(:mfg_date, "can't be in the future") if  !mfg_date.blank? and mfg_date > Date.today
#  end

#  def exp_date_cannot_be_earlier_than_mfg_date
#    errors.add(:exp_date, "can't be earlier than the Manufacturing Date") if  !exp_date.blank? and !mfg_date.blank? and exp_date < mfg_date
#  end

end
