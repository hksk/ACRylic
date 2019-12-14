require 'test_helper'

class ReportControllerTest < ActionDispatch::IntegrationTest
  test "should get list" do
    get report_list_url
    assert_response :success
  end

  test "should get detail" do
    get report_detail_url
    assert_response :success
  end

  test "should get delete" do
    get report_delete_url
    assert_response :success
  end

  test "should get add" do
    get report_add_url
    assert_response :success
  end

  test "should get search" do
    get report_search_url
    assert_response :success
  end

end
