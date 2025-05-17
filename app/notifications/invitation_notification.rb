class InvitationNotification < Notification
  def message
    "#{params["first_name"]} has invited you to be friends"
  end

  def url
    "/users/#{params['slug']}"
  end
end
