require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "should get index" do
    get home_url
    assert_response :success
  end

  test "leaderboard shows top 10 users by score descending" do
    get home_url
    assert_select ".ck-card" do
      assert_select ".flex.items-center.gap-3", minimum: 1
    end
  end

  test "leaderboard highlights signed-in user when they are in top 10" do
    get home_url
    assert_select ".flex.items-center.gap-3.bg-ck-accent", count: 1
  end

end