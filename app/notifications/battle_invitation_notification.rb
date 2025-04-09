class BattleInvitationNotification < Notification
  def message
    "#{params['inviter_email']} invited you to a battle!"
  end

  def url
    room_path(params['room_code'])
  end
end
