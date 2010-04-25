class Invoice < ActiveRecord::Base
  belongs_to :store
  belongs_to :customer, :class_name => 'Store'

  validates_presence_of :store_id, :customer_id
  validate :store_and_customer_are_different

private
  def store_and_customer_are_different
    self.errors.add(:customer, "can not be the same as the store") if self.store_id == self.customer_id
  end
end
