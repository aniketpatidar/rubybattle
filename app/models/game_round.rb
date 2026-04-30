class GameRound < ApplicationRecord
  belongs_to :game
  belongs_to :challenge
  belongs_to :round_winner, class_name: "User", optional: true

  scope :ordered, -> { order(:round_number) }

  def complete!(winner:)
    update!(round_winner: winner, completed_at: Time.current)
    trigger_game_completion
  end

  private

  def trigger_game_completion
    potential_winner = game.winner_of_game
    return unless potential_winner

    game.update!(
      winner: potential_winner,
      status: :completed,
      completed_at: Time.current
    )
    game.apply_scores!
  end
end
