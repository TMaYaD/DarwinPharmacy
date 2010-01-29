require 'test_helper'

class SuppliersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user, :role => 'admin'))
    @supplier_id = Factory(:supplier).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:suppliers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create supplier" do
    assert_difference('Supplier.count') do
      post :create, :supplier => Factory.attributes_for(:supplier)
    end

    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should show supplier" do
    get :show, :id => @supplier_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @supplier_id
    assert_response :success
  end

  test "should update supplier" do
    put :update, :id => @supplier_id, :supplier => Factory.attributes_for(:supplier)
    assert_redirected_to supplier_path(assigns(:supplier))
  end

  test "should destroy supplier" do
    assert_difference('Supplier.count', -1) do
      delete :destroy, :id => @supplier_id
    end

    assert_redirected_to suppliers_path
  end
end
