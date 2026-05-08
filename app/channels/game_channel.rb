class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find_by(id: params[:game_id])
    stream_from "game_#{game.id}" if game&.participant?(current_user)
  end

  def unsubscribed
  end

  def receive(data)
    game = Game.find_by(id: params[:game_id])
    return unless game&.participant?(current_user)

    case data["type"]
    when "code_update"
      ActionCable.server.broadcast("game_#{game.id}", {
        type: "code_update", code: data["code"], user_id: current_user.id, user_name: current_user.full_name
      })
    when "round_won"
      round = game.game_rounds.find_by(id: data["round_id"])
      return unless round

      round.update_column(:challenger_code, data["code"]) if game.challenger == current_user
      round.update_column(:opponent_code,   data["code"]) if game.opponent  == current_user

      round.complete!(winner: current_user)
    end
  end
end
