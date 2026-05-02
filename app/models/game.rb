class Game < ApplicationRecord
  belongs_to :challenger, class_name: "User"
  belongs_to :opponent,   class_name: "User"
  belongs_to :winner,     class_name: "User", optional: true

  has_many :game_rounds, dependent: :destroy

  enum :status,      { pending: 0, active: 1, completed: 2 }
  enum :round_count, { one: 0, three: 1, five: 2 }
  enum :difficulty,  { easy: 0, medium: 1, hard: 2 }

  ROUNDS_TO_WIN   = { "one" => 1, "three" => 2, "five" => 3 }.freeze
  ROUND_COUNT_NUM = { "one" => 1, "three" => 3, "five" => 5 }.freeze

  def participant?(user)
    challenger_id == user.id || opponent_id == user.id
  end

  def winner_of_game
    wins = game_rounds.where.not(round_winner_id: nil).group(:round_winner_id).count
    target = ROUNDS_TO_WIN[round_count]

    winner_id, count = wins.max_by { |_, c| c }
    return nil if count.nil? || count < target

    [ challenger, opponent ].find { |u| u.id == winner_id }
  end

  def apply_scores!
    game_winner = winner_of_game
    return unless game_winner

    loser = game_winner == challenger ? opponent : challenger
    completed = game_rounds.where.not(round_winner_id: nil)

    winner_rounds = completed.where(round_winner_id: game_winner.id).count
    loser_rounds  = completed.where(round_winner_id: loser.id).count

    winner_delta = GameScorer.score_for_winner(
      rounds_won: winner_rounds, rounds_lost: loser_rounds, opponent_score: loser.score
    )
    loser_delta = GameScorer.score_for_loser(rounds_won: loser_rounds)

    Game.transaction do
      game_winner.increment!(:score, winner_delta)
      loser.increment!(:score, loser_delta) if loser_delta > 0
    end
  end
end
