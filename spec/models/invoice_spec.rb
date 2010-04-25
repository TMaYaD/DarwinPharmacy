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

  it "should generate a bill number unique to the store in case it is not given"

  it "should be audited"
end
