require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @user_id = Factory(:user).to_param
    UserSession.create(Factory(:user, :role => 'admin'))
  end
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, :user => Factory.attributes_for(:user)
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, :id => @user_id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @user_id
    assert_response :success
  end

  test "should update user" do
    put :update, :id => @user_id, :user => { :password => 'newpass', :password_confirmation => 'newpass' }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, :id => @user_id
    end

    assert_redirected_to users_path
  end
end
