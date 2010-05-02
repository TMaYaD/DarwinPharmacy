require 'spec_helper'

describe "/invoices/new.html.erb" do
  include InvoicesHelper

  before(:each) do
    assigns[:invoice] = stub_model(Invoice,
      :new_record? => true,
      :invoice_number => "value for invoice_number",
      :store => 1,
      :customer => 1
    )
  end

  it "renders new invoice form" do
    render

    response.should have_tag("form[action=?][method=post]", invoices_path) do
      with_tag("input#invoice_invoice_number[name=?]", "invoice[invoice_number]")
      with_tag("select#invoice_store_id[name=?]", "invoice[store_id]")
      with_tag("select#invoice_customer_id[name=?]", "invoice[customer_id]")
    end
  end

  it "should have at least one set of fields for invoice items"
  it "should allow to add more than one invoice items" do
    render

    response.should have_tag("a", :text => "Add Item")
  end
end
