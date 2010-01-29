require 'test_helper'

class ProductBatchesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user))
    @product_batch_id = Factory(:product_batch).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:product_batches)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create product_batch" do
    assert_difference('ProductBatch.count') do
      post :create, :product_batch => Factory.attributes_for(:product_batch, :product => Factory(:product))
    end

    assert_redirected_to product_batch_path(assigns(:product_batch))
  end

  test "should show product_batch" do
    get :show, :id => @product_batch_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @product_batch_id
    assert_response :success
  end

  test "should update product_batch" do
    put :update, :id => @product_batch_id, :product_batch => Factory.attributes_for(:product_batch)
    assert_redirected_to product_batch_path(assigns(:product_batch))
  end

  test "should destroy product_batch" do
    UserSession.create(Factory(:user, :role => 'admin'))
    assert_difference('ProductBatch.count', -1) do
      delete :destroy, :id => @product_batch_id
    end

    assert_redirected_to product_batches_path
  end
end
