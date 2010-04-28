require File.dirname(__FILE__) + '/../spec_helper'

describe InvoiceItem do
  it "should create a new instance given valid attributes" do
    attributes = Factory.build(:invoice_item).attributes
    InvoiceItem.create!(attributes)
  end

  it "should have non negative numeric sale quantity" do
    should allow_value(0).for :sale_quantity
    should allow_value(5).for :sale_quantity
    should_not allow_value(-5).for :sale_quantity
    should_not allow_value(nil).for :sale_quantity
    should_not allow_value('ten').for :sale_quantity
  end

  it "should have a valid product batch" do
    attributes = Factory.build(:invoice_item, :product_batch => nil).attributes
    lambda{
      InvoiceItem.create!(attributes)
    }.should raise_exception ActiveRecord::RecordInvalid, "Validation failed: Product batch can't be blank"

  end
  it "should calculate amount" do
    # Make sure the calculation is working
    invoice_item = Factory(:invoice_item, :sale_quantity => 10, :free_quantity => 2, :rate => 100, :discount => 10, :vat => 4)
    invoice_item.amount.should eql 936

    # should round off to nearest paise
    invoice_item = Factory(:invoice_item, :sale_quantity => 2, :free_quantity => 2, :rate => 45, :discount => 5, :vat => 14.5)
    invoice_item.amount.should eql 97.90
  end

  it "should belong to an invoice"

  it "should change running stock inventories when created"
  it "should change running stock inventories when deleted"
  it "should change running stock inventories when edited"
end
