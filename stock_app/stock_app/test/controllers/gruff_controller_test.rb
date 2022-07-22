require "test_helper"

class GruffControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get gruff_show_url
    assert_response :success
  end
end
