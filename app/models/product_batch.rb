class ProductBatch < ActiveRecord::Base
  acts_as_audited

  belongs_to :product
  include Product::AutocompleteFields

  has_many :purchase_bill_items
  has_many :sale_bill_items
  has_many :bill_items

  VATS = [0, 4, 14.5]

  validates_presence_of :product_id, :batch_code, :exp_date, :mrp
  # validates_presence_of :mfg_date 
  validates_numericality_of :mrp, :greater_than => 0
  validates_numericality_of :pack, :only_integer => true, :greater_than => 0
  #validates_uniqueness_of :batch_code, :scope => :product_id
  validate_on_create :uniqueness_of_batch_code
  validate :exp_date_cannot_be_in_the_past
  # :exp_date_cannot_be_earlier_than_mfg_date,
  # :mfg_date_cannot_be_in_the_future
  # :has_profit
  #validates_inclusion_of :vat, :in => VATS

  after_save :update_product

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
      self.errors.add(:pack, "doesn't match with stored value :#{existing.pack}") unless self.pack == existing.pack
      self.errors.add(:exp_date, "doesn't match with stored value :#{existing.exp_date.strftime("%Y %B")}") unless self.exp_date.year == existing.exp_date.year && self.exp_date.month == existing.exp_date.month
      #self.errors.add(:rate, "doesn't match with stored value :#{existing.rate}") unless self.rate == existing.rate
      self.errors.add(:mrp, "doesn't match with stored value :#{existing.mrp}") unless self.mrp == existing.mrp
      #self.errors.add(:vat, "doesn't match with stored value :#{existing.vat}") unless self.vat == existing.vat
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

  def update_product
    self.product.mrp = self.mrp
    self.product.rate = self.rate
    self.product.vat = self.vat
    self.product.pack = self.pack
    self.product.save
  end

end
