require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  test "create: happy path creates pending game with rounds and notifies opponent" do
    assert_difference ["Game.count", "GameRound.count", "GameInviteNotification.count"], 1 do
      post games_path, params: {
        opponent_id: users(:two).id,
        round_count: "one",
        difficulty:  "easy"
      }
    end

    game = Game.last
    assert_redirected_to game_path(game)
    assert game.pending?
    assert_equal users(:one), game.challenger
    assert_equal users(:two), game.opponent
    assert_equal "easy",      game.difficulty
    assert_equal challenges(:one), game.game_rounds.first.challenge

    notification = GameInviteNotification.last
    assert_equal users(:two), notification.user
    assert_includes notification.message, users(:one).full_name
  end

  test "create: non-friend cannot be challenged" do
    assert_no_difference "Game.count" do
      post games_path, params: {
        opponent_id: users(:three).id,
        round_count: "one",
        difficulty:  "easy"
      }
    end

    assert_redirected_to root_path
    assert_equal "You can only challenge friends.", flash[:alert]
  end

  test "accept: opponent transitions game to active and sets started_at" do
    sign_in users(:two)
    game = games(:pending_game)

    post accept_game_path(game)

    game.reload
    assert game.active?
    assert_not_nil game.started_at
    assert_redirected_to game_path(game)
  end

  test "decline: opponent destroys game and associated rounds" do
    sign_in users(:two)
    game = games(:pending_game)

    assert_difference ["Game.count", "GameRound.count"], -1 do
      post decline_game_path(game)
    end

    assert_redirected_to root_path
    assert_equal "Game declined.", flash[:notice]
  end

  test "accept: challenger cannot accept their own game" do
    game = games(:pending_game)

    post accept_game_path(game)

    game.reload
    assert game.pending?
    assert_redirected_to game_path(game)
  end

  test "accept: non-pending game cannot be accepted" do
    sign_in users(:two)
    game = games(:pending_game)
    game.update!(status: :active, started_at: Time.current)

    post accept_game_path(game)

    assert_redirected_to game_path(game)
  end
end
