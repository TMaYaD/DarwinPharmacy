require 'test_helper'

class SaleBillsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user))
    @sale_bill_id = Factory(:sale_bill).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:sale_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sale_bill" do
    assert_difference('SaleBill.count') do
      post :create, :sale_bill => Factory.attributes_for(:sale_bill, :franchise_name => Factory(:franchise).name)
    end

    assert_redirected_to sale_bill_path(assigns(:sale_bill))
  end

  test "should show sale_bill" do
    get :show, :id => @sale_bill_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @sale_bill_id
    assert_response :success
  end

  test "should update sale_bill" do
    put :update, :id => @sale_bill_id, :sale_bill => Factory.attributes_for(:sale_bill)
    assert_redirected_to sale_bill_path(assigns(:sale_bill))
  end

  test "should destroy sale_bill" do
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('SaleBill.count', -1) do
      delete :destroy, :id => @sale_bill_id
    end

    assert_redirected_to sale_bills_path
  end
end
