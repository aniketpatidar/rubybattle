class ChallengesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_challenge, only: [:show, :start_random_battle, :invite_user]

  def index
    @challenges = Challenge.all
    @challenges = @challenges.where(difficulty: params[:difficulty]) if params[:difficulty].present?
    @selected_difficulty = params[:difficulty]
  end

  def show
    users_online = Kredis.unique_list("users_online").elements
    @online_users = User.where.not(id: current_user.id)
                       .where(id: users_online)
  end

  def start_random_battle
    users_online = Kredis.unique_list("users_online").elements
    online_user = User.where.not(id: current_user.id)
                     .where(id: users_online)
                     .order("RANDOM()")
                     .first

    if online_user
      create_room_with_users(@challenge, [current_user, online_user])
    else
      redirect_to challenge_path(@challenge), alert: "No online users available for battle"
    end
  end

  def invite_user
    user = current_user
    opponent = User.find(params[:user_id])
    room = create_room_with_users(@challenge, [user, opponent])
    
    BattleInvitation.create!(
      user: user,
      opponent: opponent,
      room: room,
      confirmed: false
    )

    redirect_to room_path(room.code), notice: "Battle invitation sent!"
  end

  private

  def set_challenge
    @challenge = Challenge.find(params[:id])
  end

  def create_room_with_users(challenge, users)
    room = Room.create!(challenge: challenge, status: :waiting)
    users.each { |user| room.room_participants.create!(user: user) }
    room
  end
end
