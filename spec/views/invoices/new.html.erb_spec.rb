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
      with_tag("input#invoice_store[name=?]", "invoice[store]")
      with_tag("input#invoice_customer[name=?]", "invoice[customer]")
    end
  end
end
