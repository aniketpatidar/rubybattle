require "test_helper"

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get challenges_index_url
    assert_response :success
  end

  test "should get show" do
    get challenges_show_url
    assert_response :success
  end
end
