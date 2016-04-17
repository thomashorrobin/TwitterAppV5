require 'test_helper'

class ApiCallLogsControllerTest < ActionController::TestCase
  setup do
    @api_call_log = api_call_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:api_call_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create api_call_log" do
    assert_difference('ApiCallLog.count') do
      post :create, api_call_log: { call_date_time: @api_call_log.call_date_time, call_description: @api_call_log.call_description, end_point_path: @api_call_log.end_point_path, records_inserted: @api_call_log.records_inserted, successful: @api_call_log.successful, twitter_handle: @api_call_log.twitter_handle }
    end

    assert_redirected_to api_call_log_path(assigns(:api_call_log))
  end

  test "should show api_call_log" do
    get :show, id: @api_call_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @api_call_log
    assert_response :success
  end

  test "should update api_call_log" do
    patch :update, id: @api_call_log, api_call_log: { call_date_time: @api_call_log.call_date_time, call_description: @api_call_log.call_description, end_point_path: @api_call_log.end_point_path, records_inserted: @api_call_log.records_inserted, successful: @api_call_log.successful, twitter_handle: @api_call_log.twitter_handle }
    assert_redirected_to api_call_log_path(assigns(:api_call_log))
  end

  test "should destroy api_call_log" do
    assert_difference('ApiCallLog.count', -1) do
      delete :destroy, id: @api_call_log
    end

    assert_redirected_to api_call_logs_path
  end
end
