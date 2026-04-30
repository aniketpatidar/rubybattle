require "test_helper"

class GameScorerTest < ActiveSupport::TestCase
  test "score_for_winner: 1-round sweep, opponent at 0" do
    assert_equal 4, GameScorer.score_for_winner(rounds_won: 1, rounds_lost: 0, opponent_score: 0)
  end

  test "score_for_winner: includes opponent score bonus below cap" do
    assert_equal 9, GameScorer.score_for_winner(rounds_won: 2, rounds_lost: 1, opponent_score: 100)
  end

  test "score_for_winner: caps opponent bonus at 50 when score is high" do
    assert_equal 55, GameScorer.score_for_winner(rounds_won: 2, rounds_lost: 0, opponent_score: 1100)
  end

  test "score_for_winner: bonus exactly at cap (opponent_score=1000)" do
    assert_equal 55, GameScorer.score_for_winner(rounds_won: 2, rounds_lost: 0, opponent_score: 1000)
  end

  test "score_for_winner: bonus just below cap (opponent_score=980)" do
    assert_equal 54, GameScorer.score_for_winner(rounds_won: 2, rounds_lost: 0, opponent_score: 980)
  end

  test "score_for_winner: rounds_lost reduces score" do
    assert_equal 4, GameScorer.score_for_winner(rounds_won: 3, rounds_lost: 2, opponent_score: 0)
  end

  test "score_for_loser: returns rounds_won when positive" do
    assert_equal 2, GameScorer.score_for_loser(rounds_won: 2)
  end

  test "score_for_loser: returns 0 when no rounds won" do
    assert_equal 0, GameScorer.score_for_loser(rounds_won: 0)
  end
end
