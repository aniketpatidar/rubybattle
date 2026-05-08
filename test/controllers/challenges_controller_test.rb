require "test_helper"

class ChallengesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "index renders" do
    get challenges_url
    assert_response :success
  end

  test "show renders" do
    get challenge_url(name: challenges(:one).name)
    assert_response :success
  end
end
