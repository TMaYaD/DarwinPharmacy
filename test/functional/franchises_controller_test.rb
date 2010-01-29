require 'test_helper'

class FranchisesControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    UserSession.create(Factory(:user, :role => 'admin'))
    @franchise_id = Factory(:franchise).to_param
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:franchises)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create franchise" do
    assert_difference('Franchise.count') do
      post :create, :franchise => Factory.attributes_for(:franchise)
    end

    assert_redirected_to franchise_path(assigns(:franchise))
  end

  test "should show franchise" do
    get :show, :id => @franchise_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @franchise_id
    assert_response :success
  end

  test "should update franchise" do
    put :update, :id => @franchise_id, :franchise => Factory.attributes_for(:franchise)
    assert_redirected_to franchise_path(assigns(:franchise))
  end

  test "should destroy franchise" do
    assert_difference('Franchise.count', -1) do
      delete :destroy, :id => @franchise_id
    end

    assert_redirected_to franchises_path
  end
end
