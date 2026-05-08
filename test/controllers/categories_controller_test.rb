require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @category = categories(:one)
  end

  test "index renders" do
    get categories_url
    assert_response :success
  end

  test "show renders" do
    get category_url(@category)
    assert_response :success
  end
end
