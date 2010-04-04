require 'test_helper'

class PurchaseBillsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user))
    Factory(:franchise, :name => "DPPL - Vijayawada")
    @purchase_bill_id = Factory(:purchase_bill).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_bill" do
    assert_difference('PurchaseBill.count') do
      post :create, :purchase_bill => Factory.attributes_for(:purchase_bill)
    end

    assert_redirected_to purchase_bill_path(assigns(:purchase_bill))
  end

  test "should show purchase_bill" do
    get :show, :id => @purchase_bill_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @purchase_bill_id
    assert_response :success
  end

  test "should update purchase_bill" do
    put :update, :id => @purchase_bill_id, :purchase_bill => Factory.attributes_for(:purchase_bill)
    assert_redirected_to purchase_bill_path(assigns(:purchase_bill))
  end

  test "should destroy purchase_bill" do
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('PurchaseBill.count', -1) do
      delete :destroy, :id => @purchase_bill_id
    end

    assert_redirected_to purchase_bills_path
  end
end
