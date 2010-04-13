require 'test_helper'

class AuditedStockRecordsControllerTest < ActionController::TestCase
  setup :activate_authlogic
  def setup
    @audited_stock_record_id = Factory(:audited_stock_record).to_param
    # All tests are run as default role operator unless other wise mentioned
    @user = Factory(:user, :role => 'admin')
    UserSession.create(@user)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:running_stock_records)
  end

#  test "should get new" do
#    get :new
#    assert_response :success
#  end
#
#  test "should create audited_stock_record" do
#    assert_difference('AuditedStockRecord.count') do
#      post :create, :audited_stock_record => Factory.attributes_for(:audited_stock_record)
#    end
#
#    assert_redirected_to audited_stock_record_path(assigns(:audited_stock_record))
#  end
#
#  test "should show audited_stock_record" do
#    get :show, :id => @audited_stock_record_id
#    assert_response :success
#  end
#
#  test "should get edit" do
#    get :edit, :id => @audited_stock_record_id
#    assert_response :success
#  end
#
#  test "should update audited_stock_record" do
#    put :update, :id => @audited_stock_record_id, :audited_stock_record => Factory.attributes_for(:audited_stock_record)
#    assert_redirected_to audited_stock_record_path(assigns(:audited_stock_record))
#  end
#
#  test "should destroy audited_stock_record" do
#    assert_difference('AuditedStockRecord.count', -1) do
#      delete :destroy, :id => @audited_stock_record_id
#    end
#
#    assert_redirected_to audited_stock_records_path
#  end
end
