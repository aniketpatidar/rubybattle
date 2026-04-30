require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "score defaults to 0" do
    user = User.create!(
      email: "new@example.com",
      password: "password",
      first_name: "New",
      last_name: "User"
    )
    assert_equal 0, user.score
  end

  test "top_10_by_score returns at most 10 users ordered by score descending" do
    11.times do |i|
      User.create!(
        email: "scoretest#{i}@example.com",
        password: "password",
        first_name: "Score",
        last_name: "User#{i}",
        score: (i + 1) * 10
      )
    end
    result = User.top_10_by_score
    assert result.size <= 10
    scores = result.map(&:score)
    assert_equal scores, scores.sort.reverse
  end
end
