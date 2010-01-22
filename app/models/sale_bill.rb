class SaleBill < ActiveRecord::Base
  belongs_to :franchise
  belongs_to :created_by, :class_name => 'User'
  belongs_to :modified_by, :class_name => 'User'
  has_many :sale_bill_items, :dependent => :destroy

  accepts_nested_attributes_for :sale_bill_items, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def franchise_name
    franchise.name if franchise
  end

  def franchise_name=(name)
    self.franchise = Franchise.find_by_name(name) unless name.blank?
  end
end
