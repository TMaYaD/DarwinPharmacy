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
      with_tag('input#invoice_store[name=?]', "invoice[store]")
      with_tag('input#invoice_customer[name=?]', "invoice[customer]")
    end
  end
end
