class GameResultNotification < Notification
  def message
    if params["winner_id"] == user_id
      "You beat #{params["opponent_name"]}! Game complete."
    else
      "#{params["opponent_name"]} won the game. Better luck next time!"
    end
  end

  def url
    "/games/#{params["game_id"]}"
  end
end
