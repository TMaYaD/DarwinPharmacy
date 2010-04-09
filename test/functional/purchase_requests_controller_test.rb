require 'test_helper'

class PurchaseRequestsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @franchisee = Factory(:franchisee)
    UserSession.create(@franchisee)
    Authorization.current_user = @franchisee
    @purchase_request_id = Factory(:purchase_request, :franchise => @franchisee.franchises[0]).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:purchase_requests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create purchase_request" do
    assert_difference('PurchaseRequest.count') do
      post :create, :purchase_request => Factory.attributes_for(:purchase_request)
    end

    assert_redirected_to purchase_request_path(assigns(:purchase_request))
  end

  test "should show purchase_request" do
    get :show, :id => @purchase_request_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @purchase_request_id
    assert_response :success
  end

  test "should update purchase_request" do
    put :update, :id => @purchase_request_id, :purchase_request => Factory.attributes_for(:purchase_request)
    assert_redirected_to purchase_request_path(assigns(:purchase_request))
  end

  test "should destroy purchase_request" do
    assert_difference('PurchaseRequest.count', -1) do
      delete :destroy, :id => @purchase_request_id
    end

    assert_redirected_to purchase_requests_path
  end
end
