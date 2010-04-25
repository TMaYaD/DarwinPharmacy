require 'spec_helper'

describe Invoice do
  it "should create a new instance given valid attributes" do
    attributes = Factory.build(:invoice).attributes
    Invoice.create!(attributes)
  end

  it "should belong to a valid store" do
    attributes = Factory.build(:invoice, :store => nil).attributes
    lambda{ Invoice.create!(attributes) }.should raise_exception
  end

  it "should be created for a valid customer" do
    attributes = Factory.build(:invoice, :customer => nil).attributes
    lambda{ Invoice.create!(attributes) }.should raise_exception
  end

  it "s customer should not be the same as store" do
    store = Factory(:store)
    attributes = Factory.build(:invoice, :store => store, :customer => store).attributes
    lambda{ Invoice.create!(attributes) }.should raise_exception
  end

  it "should generate a bill number unique to the store in case it is not given" do
    invoice = Factory(:invoice, :invoice_number => nil)
    invoice.invoice_number.should_not be_nil
  end

  it "should be audited" do
    Invoice.auditing_enabled.should be true
  end

  it "should have many items"
end
