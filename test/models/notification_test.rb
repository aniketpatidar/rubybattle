require "test_helper"

class NotificationTest < ActiveSupport::TestCase
  test "GameResultNotification message for winner" do
    notification = GameResultNotification.new(
      user: users(:one),
      params: { game_id: 1, winner_id: users(:one).id, opponent_name: "Jane" }
    )
    assert_equal "You beat Jane! Game complete.", notification.message
  end

  test "GameResultNotification message for loser" do
    notification = GameResultNotification.new(
      user: users(:one),
      params: { game_id: 1, winner_id: users(:two).id, opponent_name: "Jane" }
    )
    assert_equal "Jane won the game. Better luck next time!", notification.message
  end

  test "GameResultNotification url" do
    notification = GameResultNotification.new(
      user: users(:one),
      params: { game_id: 42, winner_id: users(:one).id, opponent_name: "Jane" }
    )
    assert_equal "/games/42", notification.url
  end
end
