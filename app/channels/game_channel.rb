class GameChannel < ApplicationCable::Channel
  def subscribed
    game = Game.find_by(id: params[:game_id])
    stream_from "game_#{game.id}" if game&.participant?(current_user)
  end

  def unsubscribed
  end
end
