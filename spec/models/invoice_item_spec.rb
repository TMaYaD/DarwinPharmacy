require File.dirname(__FILE__) + '/../spec_helper'

describe InvoiceItem do
  it "should be valid" do
    InvoiceItem.new.should be_valid
  end
end
