require File.dirname(__FILE__) + '/../spec_helper'
 
describe InvoicesController do
  fixtures :all
  integrate_views
  
  it "index action should render index template" do
    get :index
    response.should render_template(:index)
  end
  
  it "show action should render show template" do
    get :show, :id => Factory.create(:invoice).id
    response.should render_template(:show)
  end

  
  it "new action should render new template" do
    get :new
    response.should render_template(:new)
  end
  
  it "create action should render new template when model is invalid" do
    Invoice.any_instance.stubs(:valid?).returns(false)
    post :create
    response.should render_template(:new)
  end
  
  it "create action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    post :create
    response.should redirect_to(invoice_url(assigns[:invoice]))
  end
  
  it "edit action should render edit template" do
    get :edit, :id => Factory.create(:invoice).id
    response.should render_template(:edit)
  end

  
  it "update action should render edit template when model is invalid" do
    invoice = Factory.create(:invoice)
    Invoice.any_instance.stubs(:valid?).returns(false)
    put :update, :id => invoice.id
    response.should render_template(:edit)
  end

  it "update action should redirect when model is valid" do
    Invoice.any_instance.stubs(:valid?).returns(true)
    invoice = Factory.create(:invoice)
    put :update, :id => invoice
    response.should redirect_to(invoice_url(assigns[:invoice]))
  end

  
  it "destroy action should destroy model and redirect to index action" do
    invoice = Factory.create(:invoice)
    delete :destroy, :id => invoice
    response.should redirect_to(invoices_url)
    Invoice.exists?(invoice.id).should be_false
  end
end
