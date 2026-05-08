require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
  end

  def active_game_attrs
    {
      challenger: users(:one), opponent: users(:two),
      round_count: :one, difficulty: :easy, status: :active
    }
  end

  def create_active_game!
    game = Game.create!(active_game_attrs)
    game.game_rounds.create!(challenge: challenges(:one), round_number: 1)
    game
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

  test "round_won: happy path completes round and returns ok" do
    game = create_active_game!
    round = game.game_rounds.first

    post round_won_game_path(game), params: { round_id: round.id, code: "def sum(a,b);end" }

    assert_response :ok
    assert_not_nil round.reload.completed_at
    assert_equal users(:one), round.round_winner
  end

  test "round_won: completes game and creates notifications when majority reached" do
    game = create_active_game!
    round = game.game_rounds.first

    assert_difference "GameResultNotification.count", 2 do
      post round_won_game_path(game), params: { round_id: round.id, code: "def sum(a,b);end" }
    end

    game.reload
    assert game.completed?
    assert_equal users(:one), game.winner

    notifications = GameResultNotification.last(2)
    assert_equal [users(:one), users(:two)], notifications.map(&:user)
  end

  test "round_won: returns forbidden when game is not active" do
    game = games(:pending_game)
    round = game.game_rounds.first

    post round_won_game_path(game), params: { round_id: round.id, code: "code" }

    assert_response :forbidden
  end

  test "round_won: returns forbidden for non-participant" do
    sign_in users(:three)
    game = create_active_game!
    round = game.game_rounds.first

    post round_won_game_path(game), params: { round_id: round.id, code: "code" }

    assert_response :forbidden
  end

  test "round_won: returns not_found for invalid round_id" do
    game = create_active_game!

    post round_won_game_path(game), params: { round_id: 99999, code: "code" }

    assert_response :not_found
  end

  test "round_won: returns ok when round already completed (idempotent)" do
    game = create_active_game!
    round = game.game_rounds.first
    round.update!(round_winner: users(:one), completed_at: Time.current)

    post round_won_game_path(game), params: { round_id: round.id, code: "code" }

    assert_response :ok
  end
end
