# app/controllers/invitations_controller.rb
class InvitationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @invitations = current_user.invitations
    @friends = current_user.friends
  end

  def create
    @user = User.find(params[:user_id])
    current_user.send_invitation(@user)
    redirect_to invitations_path, notice: 'Invitation sent successfully.'
  end

  def accept
    @invitation = current_user.pending_invitations.find(params[:id])
    @invitation.update(confirmed: true)
    respond_to do |format|
      render turbo_stream: [
        turbo_stream.remove(@invitation),
        turbo_stream.append("friendsList", partial: "friend", locals: { friend: @invitation.friend })
      ]
    end
  end

  def decline
    invitation = current_user.received_invitations.find(params[:id])
    invitation.destroy
    redirect_to invitations_path, notice: "Invitation declined"
  end
end