require 'test_helper'

class StockInventoriesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @stock_inventory_id = Factory(:stock_inventory).to_param
    # All tests are run as default role operator unless other wise mentioned
    @user = Factory(:user, :role => 'admin')
    UserSession.create(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_inventories)
  end

#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create stock_inventory" do
#    assert_difference('StockInventory.count') do
#      post :create, :stock_inventory => Factory.attributes_for(:stock_inventory)
#    end
#
#    assert_redirected_to stock_inventory_path(assigns(:stock_inventory))
#  end
#
#  test "should show stock_inventory" do
#    get :show, :id => @stock_inventory_id
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @stock_inventory_id
#    assert_response :success
#  end
#
#  test "should update stock_inventory" do
#    put :update, :id => @stock_inventory_id, :stock_inventory => Factory.attributes_for(:stock_inventory)
#    assert_redirected_to stock_inventory_path(assigns(:stock_inventory))
#  end
#
#  test "should destroy stock_inventory" do
#    assert_difference('StockInventory.count', -1) do
#      delete :destroy, :id => @stock_inventory_id
#    end
#
#    assert_redirected_to stock_inventories_path
#  end
end
