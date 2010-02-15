class Bill < ActiveRecord::Base
  using_access_control

  belongs_to :customer
  belongs_to :franchise
  belongs_to :created_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"
  has_many :bill_items, :dependent => :destroy

  validates_associated :bill_items
  validates_size_of :bill_items, :minimum => 1
  #validates_presence_of :customer_id
  
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
end
