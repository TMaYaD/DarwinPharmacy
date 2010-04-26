class Invoice < ActiveRecord::Base
  acts_as_audited
  
  belongs_to :store
  belongs_to :customer, :class_name => 'Store'

  has_many :invoice_items

  validates_presence_of :store_id, :customer_id
  validate :store_and_customer_are_different

  after_save :set_invoice_number_if_missing

private
  def store_and_customer_are_different
    self.errors.add(:customer, "can not be the same as the store") if self.store_id == self.customer_id
  end

  def set_invoice_number_if_missing
    self.invoice_number ||= self.id
  end
end
