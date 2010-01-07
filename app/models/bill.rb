class Bill < ActiveRecord::Base
  belongs_to :customer
  belongs_to :created_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"
  has_many :bill_items, :dependent => :destroy

  validates_associated :bill_items
  validates_size_of :bill_items, :minimum => 1
  validates_presence_of :customer_id
  
  accepts_nested_attributes_for :customer
  accepts_nested_attributes_for :bill_items, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def amount
    sum = 0
    self.bill_items.each { |item| sum += item.price }
    sum
  end
end
