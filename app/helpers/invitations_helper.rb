module InvitationsHelper
  def friendship_state(current_user, user)
    return :self if current_user == user
    return :friends if current_user.friend_with?(user)
    return :invitation_received if current_user.pending_invitations.exists?(user_id: user.id)
    return :invitation_sent if current_user.sent_invitations.exists?(friend_id: user.id)
    :none
  end
end
