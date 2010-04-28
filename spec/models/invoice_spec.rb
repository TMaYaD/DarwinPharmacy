require 'spec_helper'

describe Invoice do
  it "should create a new instance given valid attributes" do
    attributes = Factory.build(:invoice).attributes
    Invoice.create!(attributes)
  end

  it "should belong to a valid store" do
    attributes = Factory.build(:invoice, :store => nil).attributes
    lambda{
      Invoice.create!(attributes)
    }.should raise_exception ActiveRecord::RecordInvalid, "Validation failed: Store can't be blank"
  end

  it "should not be created without a valid customer" do
    attributes = Factory.build(:invoice, :customer => nil).attributes
    lambda{
      Invoice.create!(attributes)
    }.should raise_exception ActiveRecord::RecordInvalid, "Validation failed: Customer can't be blank"
  end

  it "'s customer should not be the same as store" do
    store = Factory(:store)
    attributes = Factory.build(:invoice, :store => store, :customer => store).attributes
    lambda{
      Invoice.create!(attributes)
    }.should raise_exception ActiveRecord::RecordInvalid, "Validation failed: Customer can not be the same as the store"
  end

  it "should generate a bill number unique to the store in case it is not given" do
    invoice = Factory(:invoice, :invoice_number => nil)
    invoice.invoice_number.should_not be_nil
  end

  it "should be audited" do
    Invoice.auditing_enabled.should be true
  end

  it "should have many items" do
    should have_many :invoice_items
  end

  it "should take attributes for invoice item" do
    invoice_item_attributes = Factory.build(:invoice_item).attributes
    invoice_attributes = Factory.build(:invoice, :invoice_items_attributes => { 0 => invoice_item_attributes}).attributes
    Invoice.create!(invoice_attributes)
  end

  it "should delete associated invoice items when deleted"
  it "should have a state (draft, billed, verified, accepted)"
  it "should be accepted only by the customer user"
  it "should be billed only by the store user"
  it "shuold be verified by the the store user"
  it "should not be verified by the same user as the billed"
  
end
