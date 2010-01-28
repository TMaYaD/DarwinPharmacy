require 'test_helper'

class ProductsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @product_id = Factory(:product).to_param
    # All tests are run as default role operator unless other wise mentioned
    @user = Factory(:user)
    UserSession.create(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product" do
    assert_difference('Product.count') do
      post :create, :product => Factory.attributes_for(:product)
    end

    assert_redirected_to product_path(assigns(:product))
  end

  test "should show product" do
    get :show, :id => @product_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_id
    assert_response :success
  end

  test "should update product" do
    put :update, :id => @product_id, :product => Factory.attributes_for(:product)
    assert_redirected_to product_path(assigns(:product))
  end

  test "should destroy product" do
    # Only an admin can delete a product
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('Product.count', -1) do
      delete :destroy, :id => @product_id
    end

    assert_redirected_to products_path
  end
end
