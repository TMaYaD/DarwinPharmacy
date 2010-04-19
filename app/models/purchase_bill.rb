class PurchaseBill < ActiveRecord::Base
  acts_as_audited

  belongs_to :supplier
  has_many :purchase_bill_items, :dependent => :destroy

  validates_associated :purchase_bill_items
  validates_size_of :purchase_bill_items, :minimum => 1
  validates_presence_of :supplier_name, :due_date, :bill_number

  accepts_nested_attributes_for :purchase_bill_items, :allow_destroy => true, :reject_if => proc { |attrs|
    attrs[:product_batch_attributes][:product_name].blank? &&
    attrs[:product_batch_attributes][:batch_code].blank? &&
    attrs[:product_batch_attributes][:rate].blank? &&
    attrs[:product_batch_attributes][:mrp].blank? &&
    attrs[:sale_quantity].blank?
  }

  def supplier_name
    supplier.name if supplier
  end

  def supplier_name=(name)
    self.supplier = Supplier.find_or_create_by_name(name) unless name.blank?
  end

  def amount
    self.purchase_bill_items.reduce(0) { |sum, item| sum += item.amount }
  end

  def net_amount
    self.purchase_bill_items.reduce(0) { |sum, item| sum += item.net_amount }
  end

  def tax
    self.purchase_bill_items.reduce({}) { |sum, item| sum = item.tax_add(sum) }
  end

end
