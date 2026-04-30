class GameScorer
  def self.score_for_winner(rounds_won:, rounds_lost:, opponent_score:)
    rounds_won + 3 + [opponent_score / 20, 50].min - rounds_lost
  end

  def self.score_for_loser(rounds_won:)
    [rounds_won, 0].max
  end
end
