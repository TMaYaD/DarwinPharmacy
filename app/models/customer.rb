class Customer < ActiveRecord::Base
  acts_as_audited

  has_many :bills

  validates_presence_of :name, :phone, :address
  validates_numericality_of :phone, :only_integer => true, :greater_than => 1000000000, :less_than => 9999999999
  validates_uniqueness_of :phone
  validate_on_create :uniqueness_of_phone
  validates_length_of :name, :minimum => 5
  validates_length_of :address, :minimum => 15

private
  def uniqueness_of_phone
    existing = Customer.find_by_phone(self.phone)
    if existing
    then
      if self.name == existing.name && self.address == existing.address
      then
        self.id = existing.id
      else
        self.errors.add( :phone, :taken)
      end
    end
  end
end
