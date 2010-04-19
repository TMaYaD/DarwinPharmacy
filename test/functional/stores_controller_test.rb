require 'test_helper'

class StoresControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user, :role => 'admin'))
    @store_id = Factory(:store).to_param
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stores)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create store" do
    assert_difference('Store.count') do
      post :create, :store => Factory.attributes_for(:store)
    end

    assert_redirected_to store_path(assigns(:store))
  end

  test "should show store" do
    get :show, :id => @store_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @store_id
    assert_response :success
  end

  test "should update store" do
    put :update, :id => @store_id, :store => Factory.attributes_for(:store)
    assert_redirected_to store_path(assigns(:store))
  end

  test "should destroy store" do
    assert_difference('Store.count', -1) do
      delete :destroy, :id => @store_id
    end

    assert_redirected_to stores_path
  end
end
