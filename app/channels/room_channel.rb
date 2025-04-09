class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = Room.find_by(code: params[:room_code])
    
    if @room.nil?
      reject
      return
    end

    unless @room.is_participant?(current_user)
      reject
      return
    end

    stream_from "room_#{@room.code}_channel"
    @room.broadcast_room_update
  end

  def unsubscribed
    if @room
      @room.player_disconnected(current_user)
      @room.broadcast_room_update
    end
  end

  def check_readiness
    if @room
      @room.broadcast_readiness
      @room.broadcast_room_update
    end
  end

  def mark_player_ready
    @room.set_player_ready(current_user)
  end

  def broadcast_readiness
    room = Room.find_by(code: params[:room_code])
    return unless room

    participants = room.room_participants.includes(:user).order(:created_at)

    player1_ready = participants.first&.subscribed? || false
    player2_ready = participants.second&.subscribed? || false

    broadcast_to room, readiness_update: {
      player1_ready: player1_ready,
      player2_ready: player2_ready,
      both_players_ready: player1_ready && player2_ready,
      room_status: room.status || 'unknown',
      can_start_battle: room.can_start_battle?,
      participants_count: participants.count,
      debug_info: {
        player1_user_id: participants.first&.user_id,
        player2_user_id: participants.second&.user_id,
        player1_subscription_status: participants.first&.subscription_status,
        player2_subscription_status: participants.second&.subscription_status,
        room_id: room.id,
        room_code: room.code
      }
    }
  end
end
