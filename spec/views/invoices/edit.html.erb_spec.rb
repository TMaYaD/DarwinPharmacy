require 'spec_helper'

describe "/invoices/edit.html.erb" do
  include InvoicesHelper

  before(:each) do
    assigns[:invoice] = @invoice = stub_model(Invoice,
      :new_record? => false,
      :invoice_number => "value for invoice_number",
      :store => 1,
      :customer => 1
    )
  end

  it "renders the edit invoice form" do
    render

    response.should have_tag("form[action=#{invoice_path(@invoice)}][method=post]") do
      with_tag('input#invoice_invoice_number[name=?]', "invoice[invoice_number]")
      with_tag('select#invoice_store_id[name=?]', "invoice[store_id]")
      with_tag('select#invoice_customer_id[name=?]', "invoice[customer_id]")
    end
  end

  it "should allow to add more than one invoice items" do
    render

    response.should have_tag("a", :text => "Add Item")
  end
end
