require "test_helper"

class GameTest < ActiveSupport::TestCase
  def setup
    @challenger = User.create!(
      email: "challenger@example.com", password: "password",
      first_name: "Alice", last_name: "Challenger"
    )
    @opponent = User.create!(
      email: "opponent@example.com", password: "password",
      first_name: "Bob", last_name: "Opponent"
    )
    @challenge = Challenge.create!(
      name: "test_challenge_#{SecureRandom.hex(4)}", difficulty: :easy,
      language: "ruby", tests: [], method_template: "def foo\nend"
    )
    @game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :one, difficulty: :easy
    )
  end

  test "status defaults to pending" do
    assert @game.pending?
  end

  test "status transitions pending -> active -> completed" do
    @game.active!
    assert @game.active?
    @game.completed!
    assert @game.completed?
  end

  test "belongs_to challenger and opponent" do
    assert_equal @challenger, @game.challenger
    assert_equal @opponent,   @game.opponent
  end

  test "winner is optional" do
    assert_nil @game.winner
  end

  test "winner_of_game returns nil with no completed rounds" do
    assert_nil @game.winner_of_game
  end

  test "winner_of_game returns challenger after winning 1-round game" do
    GameRound.create!(
      game: @game, challenge: @challenge, round_number: 1,
      round_winner: @challenger, completed_at: Time.current
    )
    assert_equal @challenger, @game.winner_of_game
  end

  test "winner_of_game returns nil when no majority yet in 3-round game" do
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :three, difficulty: :easy
    )
    GameRound.create!(
      game: game, challenge: @challenge, round_number: 1,
      round_winner: @challenger, completed_at: Time.current
    )
    assert_nil game.winner_of_game
  end

  test "winner_of_game returns winner when majority reached in 3-round game" do
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :three, difficulty: :easy
    )
    GameRound.create!(
      game: game, challenge: @challenge, round_number: 1,
      round_winner: @challenger, completed_at: Time.current
    )
    GameRound.create!(
      game: game, challenge: @challenge, round_number: 2,
      round_winner: @challenger, completed_at: Time.current
    )
    assert_equal @challenger, game.winner_of_game
  end

  test "winner_of_game returns winner at majority in 5-round game" do
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :five, difficulty: :easy
    )
    [1, 2].each do |n|
      GameRound.create!(
        game: game, challenge: @challenge, round_number: n,
        round_winner: @opponent, completed_at: Time.current
      )
    end
    assert_nil game.winner_of_game

    GameRound.create!(
      game: game, challenge: @challenge, round_number: 3,
      round_winner: @opponent, completed_at: Time.current
    )
    assert_equal @opponent, game.winner_of_game
  end

  test "apply_scores! increases winner score" do
    @challenger.update!(score: 0)
    @opponent.update!(score: 80)
    GameRound.create!(
      game: @game, challenge: @challenge, round_number: 1,
      round_winner: @challenger, completed_at: Time.current
    )
    @game.apply_scores!
    assert_equal 8, @challenger.reload.score
  end

  test "apply_scores! increases loser score when they won rounds" do
    @challenger.update!(score: 0)
    @opponent.update!(score: 0)
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :three, difficulty: :easy
    )
    GameRound.create!(game: game, challenge: @challenge, round_number: 1,
      round_winner: @challenger, completed_at: Time.current)
    GameRound.create!(game: game, challenge: @challenge, round_number: 2,
      round_winner: @opponent, completed_at: Time.current)
    GameRound.create!(game: game, challenge: @challenge, round_number: 3,
      round_winner: @challenger, completed_at: Time.current)
    game.apply_scores!
    assert_equal 4, @challenger.reload.score
    assert_equal 1, @opponent.reload.score
  end

  test "apply_scores! does nothing when no majority winner" do
    @challenger.update!(score: 10)
    @opponent.update!(score: 10)
    @game.apply_scores!
    assert_equal 10, @challenger.reload.score
    assert_equal 10, @opponent.reload.score
  end
end
