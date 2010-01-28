require 'test_helper'

class CustomersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @customer_id = Factory(:customer).to_param
    UserSession.create(Factory(:user, :role => 'franchise'))
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create customer" do
    assert_difference('Customer.count') do
      post :create, :customer => Factory.attributes_for(:customer)
    end

    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should show customer" do
    get :show, :id => @customer_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @customer_id
    assert_response :success
  end

  test "should update customer" do
    put :update, :id => @customer_id, :customer => Factory.attributes_for(:customer)
    assert_redirected_to customer_path(assigns(:customer))
  end

  test "should destroy customer" do
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('Customer.count', -1) do
      delete :destroy, :id => @customer_id
    end

    assert_redirected_to customers_path
  end
end
