class PurchaseBill < ActiveRecord::Base
  belongs_to :supplier
  belongs_to :created_by, :class_name => "User"
  belongs_to :modified_by, :class_name => "User"
  has_many :purchase_bill_items, :dependent => :destroy

  validates_associated :purchase_bill_items
  validates_size_of :purchase_bill_items, :minimum => 1
  validates_presence_of :supplier_id, :due_date, :bill_number

  accepts_nested_attributes_for :purchase_bill_items, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def supplier_name
    supplier.name if supplier
  end
  
  def supplier_name=(name)
    self.supplier = Supplier.find_by_name(name) unless name.blank?
  end

end
