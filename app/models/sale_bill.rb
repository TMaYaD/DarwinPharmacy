class SaleBill < ActiveRecord::Base
  acts_as_audited

  belongs_to :franchise
  has_many :sale_bill_items, :dependent => :destroy

  validates_associated :sale_bill_items
  validates_size_of :sale_bill_items, :minimum => 1
  validates_presence_of :franchise_name

  accepts_nested_attributes_for :sale_bill_items, :allow_destroy => true, :reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }

  def franchise_name
    franchise.name if franchise
  end

  def franchise_name=(name)
    self.franchise = Franchise.find_by_name(name) unless name.blank?
  end

  def amount
   self.taxable_amount.values.reduce(0) { |sum, item| sum += item }
  end

  def net_amount
    self.taxable_amount.to_a.reduce(0) { |sum,item| sum += ((100 + item[0]) * item[1]).round()/100 }
  end

  def taxable_amount
    @taxable_amount ||= self.sale_bill_items.reduce({}) { |sum, item|
      sum[item.vat] ||= 0
      sum[item.vat] += item.amount
      sum
    }
  end

  def SaleBill.tax(sale_bills)
    sale_bills.reduce({}) { |sum, item|
      item.taxable_amount.each { |key, value|
        sum[key] ||= 0
        sum[key] += value
      }
      sum
    }
  end
end
