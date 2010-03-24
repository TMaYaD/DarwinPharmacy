require 'test_helper'

class RequirementsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @franchisee = Factory(:franchisee)
    UserSession.create(@franchisee)
    Authorization.current_user = @franchisee
    @requirement_id = Factory(:requirement, :franchise => @franchisee.franchises[0]).to_param
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:requirements)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create requirement" do
    assert_difference('Requirement.count') do
      post :create, :requirement => Factory.attributes_for(:requirement)
    end

    assert_redirected_to requirement_path(assigns(:requirement))
  end

  test "should show requirement" do
    get :show, :id => @requirement_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @requirement_id
    assert_response :success
  end

  test "should update requirement" do
    put :update, :id => @requirement_id, :requirement => Factory.attributes_for(:requirement)
    assert_redirected_to requirement_path(assigns(:requirement))
  end

  test "should destroy requirement" do
    assert_difference('Requirement.count', -1) do
      delete :destroy, :id => @requirement_id
    end

    assert_redirected_to requirements_path
  end
end
