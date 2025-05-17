class OnlineChannel < Turbo::StreamsChannel
  def subscribed
    super
    return unless current_user
    users_online = Kredis.unique_list "users_online"
    users_online << current_user.id
    Turbo::StreamsChannel.broadcast_update_to(
      verified_stream_name_from_params,
      target: "user_status_#{current_user.id}",
      partial: 'users/status',
      locals: { user: current_user, status: 'Active' }
    )
  end

  def unsubscribed
    return unless current_user
    users_online = Kredis.unique_list "users_online"
    users_online.remove current_user.id
    Turbo::StreamsChannel.broadcast_update_to(
      verified_stream_name_from_params,
      target: "user_status_#{current_user.id}",
      partial: 'users/status',
      locals: { user: current_user, status: 'Inactive' }
    )
  end
end
