require 'test_helper'

class StockInventoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:stock_inventories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create stock_inventory" do
    assert_difference('StockInventory.count') do
      post :create, :stock_inventory => { }
    end

    assert_redirected_to stock_inventory_path(assigns(:stock_inventory))
  end

  test "should show stock_inventory" do
    get :show, :id => stock_inventories(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => stock_inventories(:one).to_param
    assert_response :success
  end

  test "should update stock_inventory" do
    put :update, :id => stock_inventories(:one).to_param, :stock_inventory => { }
    assert_redirected_to stock_inventory_path(assigns(:stock_inventory))
  end

  test "should destroy stock_inventory" do
    assert_difference('StockInventory.count', -1) do
      delete :destroy, :id => stock_inventories(:one).to_param
    end

    assert_redirected_to stock_inventories_path
  end
end
