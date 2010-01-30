require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  def setup
    @user = Factory(:user)
  end

  test "should get index" do
    get_with @user, :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get_with users(:operator_one), :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post_with users(:operator_one), :create, :product => { }
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get_with users(:operator_one), :show, :id => products(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get_with users(:operator_one), :edit, :id => products(:one).to_param
    assert_response :success
  end

  test "should update product" do
    put_with users(:operator_one), :update, :id => products(:one).to_param, :product => { }
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    assert_difference('Product.count', -1) do
      delete_with users(:operator_one), :destroy, :id => products(:one).to_param
    end

    assert_redirected_to products_path
  end
end
