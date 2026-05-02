class GameInviteNotification < Notification
  def message
    "#{params["challenger_name"]} has challenged you to a #{params["round_count"]}-round Game"
  end

  def url
    "/games/#{params["game_id"]}"
  end
end
