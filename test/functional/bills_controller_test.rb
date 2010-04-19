require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @user = Factory(:user, :role => 'franchise')
    UserSession.create(@user)
    @bill_id = Factory(:bill).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
    # show customer name in index
    #assert_select 'td', 'TestCustomer'
  end


  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, :bill => Factory.attributes_for(:bill, :customer => Factory(:customer))
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, :id => @bill_id
    assert_response :success
  end

  test "should get edit" do
    UserSession.create(Factory(:user, :role => 'admin'))
    get :edit, :id => @bill_id
    assert_response :success
  end

  test "should update bill" do
    UserSession.create(Factory(:user, :role => 'admin'))
    put :update, :id => @bill_id, :bill => Factory.attributes_for(:bill)
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => @bill_id
    end

    assert_redirected_to bills_path
  end
end
