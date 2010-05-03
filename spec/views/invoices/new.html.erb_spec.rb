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

  it "should have atleast one set of fields for invoice items" do
    render
    response.should have_tag("fieldset.item", :count => 1) do
      # product name : auto complete
      with_tag("input[name=?][autocomplete]", "invoice[invoice_items_attributes][0][product_name]" )
      # product batch code: auto complete
      with_tag("input[name=?][autocomplete]", "invoice[invoice_items_attributes][0][product_batch_code]" )
      # quantity, sale and free
      with_tag("input[name=?]", "invoice[invoice_items_attributes][0][sale_quantity]" )
      with_tag("input[name=?]", "invoice[invoice_items_attributes][0][free_quantity]" )
      # discount
      with_tag("input[name=?]", "invoice[invoice_items_attributes][0][discount]" )
      # rate
      with_tag("input[name=?]", "invoice[invoice_items_attributes][0][rate]" )
      # vat
      with_tag("input[name=?]", "invoice[invoice_items_attributes][0][vat]" )
   end
  end
  it "should allow to add more than one invoice items" do
    render

    response.should have_tag("a", :text => "Add Item")
  end
  it "should allow to remove unwanted invoice items" do
    render
    response.should have_tag("fieldset.item") do
      with_tag("a", :text => "Remove Item")
    end
  end
end
