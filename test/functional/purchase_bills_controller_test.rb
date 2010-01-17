require 'test_helper'

class PurchaseBillsControllerTest < ActionController::TestCase
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
      post :create, :purchase_bill => { }
    end

    assert_redirected_to purchase_bill_path(assigns(:purchase_bill))
  end

  test "should show purchase_bill" do
    get :show, :id => purchase_bills(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => purchase_bills(:one).to_param
    assert_response :success
  end

  test "should update purchase_bill" do
    put :update, :id => purchase_bills(:one).to_param, :purchase_bill => { }
    assert_redirected_to purchase_bill_path(assigns(:purchase_bill))
  end

  test "should destroy purchase_bill" do
    assert_difference('PurchaseBill.count', -1) do
      delete :destroy, :id => purchase_bills(:one).to_param
    end

    assert_redirected_to purchase_bills_path
  end
end
