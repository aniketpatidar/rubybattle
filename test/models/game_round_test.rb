require "test_helper"

class GameRoundTest < ActiveSupport::TestCase
  def setup
    @challenger = User.create!(
      email: "ch_#{SecureRandom.hex(4)}@example.com", password: "password",
      first_name: "Alice", last_name: "C", score: 100
    )
    @opponent = User.create!(
      email: "op_#{SecureRandom.hex(4)}@example.com", password: "password",
      first_name: "Bob", last_name: "O", score: 80
    )
    @challenge = Challenge.create!(
      name: "ch_#{SecureRandom.hex(4)}", difficulty: :easy,
      language: "ruby", tests: [], method_template: "def foo\nend"
    )
    @game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :one, difficulty: :easy, status: :active
    )
    @round = GameRound.create!(
      game: @game, challenge: @challenge, round_number: 1
    )
  end

  test "complete! sets round_winner" do
    @round.complete!(winner: @challenger)
    assert_equal @challenger, @round.round_winner
  end

  test "complete! sets completed_at" do
    @round.complete!(winner: @challenger)
    assert_not_nil @round.completed_at
  end

  test "complete! marks game as completed when majority reached" do
    @round.complete!(winner: @challenger)
    assert @game.reload.completed?
  end

  test "complete! sets game winner" do
    @round.complete!(winner: @challenger)
    assert_equal @challenger, @game.reload.winner
  end

  test "complete! sets game completed_at" do
    @round.complete!(winner: @challenger)
    assert_not_nil @game.reload.completed_at
  end

  test "complete! does not complete game until majority in 3-round game" do
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :three, difficulty: :easy, status: :active
    )
    r1 = GameRound.create!(game: game, challenge: @challenge, round_number: 1)
    r1.complete!(winner: @challenger)
    assert game.reload.active?
  end

  test "complete! completes 3-round game when challenger wins 2nd round" do
    game = Game.create!(
      challenger: @challenger, opponent: @opponent,
      round_count: :three, difficulty: :easy, status: :active
    )
    r1 = GameRound.create!(game: game, challenge: @challenge, round_number: 1)
    r2 = GameRound.create!(game: game, challenge: @challenge, round_number: 2)

    r1.complete!(winner: @challenger)
    assert game.reload.active?

    r2.complete!(winner: @challenger)
    assert game.reload.completed?
    assert_equal @challenger, game.reload.winner
  end

  test "complete! updates winner score on game completion" do
    initial = @challenger.score
    @round.complete!(winner: @challenger)
    assert_equal initial + 8, @challenger.reload.score
  end

  test "complete! does not change loser score when loser won zero rounds" do
    @round.complete!(winner: @challenger)
    assert_equal 80, @opponent.reload.score
  end
end
