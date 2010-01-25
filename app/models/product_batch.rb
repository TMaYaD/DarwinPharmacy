class ProductBatch < ActiveRecord::Base
  belongs_to :product

  VATS = [4, 12.5, 14.5]

  validates_presence_of :product_id, :batch_code, :exp_date, :mrp, :rate, :vat
  # validates_presence_of :mfg_date 
  validates_numericality_of :mrp, :rate, :greater_than => 0
  #validates_uniqueness_of :batch_code, :scope => :product_id # need this temporarily for the bug in purchase bills.
  validate :exp_date_cannot_be_in_the_past
  # :exp_date_cannot_be_earlier_than_mfg_date,
  # :mfg_date_cannot_be_in_the_future
  # :has_profit
  validates_inclusion_of :vat, :in => VATS

  def product_name
    product.name if product
  end
  def product_name=(name)
    self.product = Product.find_by_name(name) unless name.blank?
  end

  def to_label
    "#{product_name} : #{batch_code}"
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
