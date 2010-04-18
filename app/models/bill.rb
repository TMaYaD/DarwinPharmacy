class Bill < ActiveRecord::Base
  using_access_control
  acts_as_audited

  belongs_to :customer
  belongs_to :franchise
  has_many :bill_items, :dependent => :destroy

  validates_associated :bill_items, :customer
  validates_size_of :bill_items, :minimum => 1
  after_validation :find_customer_if_existing
  
  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :bill_items, :allow_destroy => true, :reject_if => proc { |attrs|
    attrs[:product_name].blank? &&
    attrs[:product_batch_code].blank? &&
    attrs[:quantity].blank?
  }

  def amount
    self.bill_items.reduce(0) { |sum, item| sum += item.amount }
  end

  def savings
    self.bill_items.reduce(0) { |sum, item| sum += item.savings }
  end

private
  def find_customer_if_existing
    self.customer = Customer.find(self.customer.id) if self.customer.id
  end
end
