require 'spec_helper'

describe "/invoices/show.html.haml" do
  include InvoicesHelper
  before(:each) do
    assigns[:invoice] = @invoice = stub_model(Invoice,
      :invoice_number => "value for invoice_number",
      :store => 1,
      :customer => 1
    )
  end

  it "renders attributes in <p>" do
    render
    response.should have_text(/value\ for\ invoice_number/)
    response.should have_text(/1/)
    response.should have_text(/1/)
  end
end
