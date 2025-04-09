class Room < ApplicationRecord
  belongs_to :challenge
  has_many :room_participants
  has_many :users, through: :room_participants

  validates :code, presence: true, uniqueness: true
  validates :status, presence: true

  enum status: { waiting: 0, active: 1, completed: 2, cancelled: 3 }

  before_validation :generate_room_code, on: :create
  before_create :set_default_created_at

  def battle_state
    @battle_state ||= Kredis.hash "room:#{id}:battle"
  end

  def can_start_battle?
    return false if room_participants.count != 2

    room_participants.all?(&:subscribed?)
  end

  def start_battle!
    return false unless can_start_battle? && full? && waiting?

    battle_duration = challenge&.default_duration || 15.minutes

    battle_state.update(
      "started_at" => Time.current.to_i.to_s,
      "duration_seconds" => battle_duration.to_i.to_s,
      "winner_id" => "",
      "player1_ready" => "false",
      "player2_ready" => "false",
      "player1_code" => "",
      "player2_code" => ""
    )

    update!(status: :active)
    broadcast_replace_later
    true
  end

  def remaining_time
    return 0 if completed?
    return nil unless active?

    started_at = battle_state["started_at"].to_i
    duration = battle_state["duration_seconds"].to_i
    return nil if started_at == 0 || duration == 0

    elapsed = Time.current.to_i - started_at
    remaining = duration - elapsed
    [remaining, 0].max
  end

  def submit_solution!(user, code)
    return false unless active?

    validate_submission(user, code)

    player_number = users.index(user) + 1
    battle_state.update(
      "player#{player_number}_code" => code,
      "player#{player_number}_ready" => "true"
    )

    if both_players_ready?
      run_tests!
    end

    broadcast_replace_later
    true
  end

  def validate_submission(user, code)
    SubmissionService.new(challenge, user, code).validate
  end

  def both_players_ready?
    player1_ready? && player2_ready?
  end

  def player_ready?(user)
    player_number = users.index(user) + 1
    battle_state["player#{player_number}_ready"] == "true"
  end

  def opponent_ready?(user)
    player_number = users.index(user) + 1
    opponent_number = player_number == 1 ? 2 : 1
    battle_state["player#{opponent_number}_ready"] == "true"
  end

  def winner
    winner_id = battle_state["winner_id"]
    return nil if winner_id.blank?
    users.find { |u| u.id.to_s == winner_id }
  end

  def full?
    room_participants.count >= 2
  end

  def player1_ready?
    battle_state["player1_ready"] == 'true'
  end

  def player2_ready?
    battle_state["player2_ready"] == 'true'
  end

  def set_player_ready(user)
    room_participant = room_participants.find_by(user: user)
    room_participant.subscribe! unless room_participant.subscribed?
    room_participant.ready!
    battle_state.update(
      "player#{room_participants.order(:created_at).index(room_participant) + 1}_ready" => "true"
    )
    
    start_battle! if can_start_battle?
    true
  end

  def reset_player_ready
    battle_state["player1_ready"] = 'false'
    battle_state["player2_ready"] = 'false'

    room_participants.each do |participant|
      participant.update(subscription_status: :subscribed) if participant.ready?
    end

    broadcast_readiness
  end

  def player_disconnected(user)
    room_participant = room_participants.find_by(user: user)
    
    return if room_participant.nil?

    if room_participants.order(:created_at).first == room_participant
      battle_state["player1_ready"] = 'false'
    elsif room_participants.order(:created_at).second == room_participant
      battle_state["player2_ready"] = 'false'
    end

    broadcast_readiness

    end_battle_due_to_disconnection if both_players_present?
  end

  def end_battle_due_to_disconnection
    active_participants = room_participants.joins(:user).where(users: { online_status: 'online' })
    
    if active_participants.count == 1
      winner = active_participants.first.user
      update(winner: winner)
      
      ActionCable.server.broadcast(
        "room_#{code}_channel",
        {
          battle_ended: true,
          reason: 'Opponent disconnected',
          winner_id: winner.id
        }
      )
    end
  end

  def both_players_present?
    room_participants.count == 2
  end

  def ready_to_start?
    room_participants.count == 2
  end

  def stale?
    return false if created_at.nil?
    
    created_at < 1.minute.ago && room_participants.count < 2
  end

  def cancel_if_stale!
    if stale?
      update(status: :cancelled)
      
      ActionCable.server.broadcast(
        "room_#{code}_channel",
        {
          room_status: 'cancelled',
          reason: 'Room not filled in time'
        }
      )
      
      true
    else
      false
    end
  end

  def status
    return 'waiting' if room_participants.count < 2
    
    return 'cancelled' if stale?
    
    return 'ready' if room_participants.count == 2
    
    'pending'
  end

  def participants
    room_participants.includes(:user).order(:created_at)
  end

  def is_participant?(user)
    room_participants.exists?(user: user)
  end

  def add_participant(user)
    raise "Room is full" if full?
    existing_participant = room_participants.find_by(user: user)
    return existing_participant if existing_participant

    new_participant = room_participants.create!(
      user: user, 
      subscription_status: :pending
    )

    broadcast_readiness
    new_participant
  end

  def broadcast_readiness
    ActionCable.server.broadcast(
      "room_#{code}_channel",
      {
        readiness_update: {
          player1_ready: player1_ready?,
          player2_ready: player2_ready?
        }
      }
    )
  end

  def broadcast_room_update
    participants = room_participants.includes(:user).order(:created_at).map do |participant|
      {
        user_id: participant.user_id,
        username: participant.user.slug,
        subscription_status: participant.subscription_status,
        ready: participant.subscribed?
      }
    end

    player1_ready = false
    player2_ready = false

    if participants.size >= 1
      player1_ready = participants[0][:ready]
    end

    if participants.size >= 2
      player2_ready = participants[1][:ready]
    end

    broadcast_data = {
      readiness_update: {
        player1_ready: player1_ready,
        player2_ready: player2_ready,
        both_players_ready: player1_ready && player2_ready
      },
      room_status: status,
      participants_count: room_participants.count,
      participants: participants,
      challenge_id: challenge_id,
      challenge_name: challenge&.name,
      debug_info: {
        room_id: id,
        room_code: code,
        created_at: created_at,
        updated_at: updated_at
      }
    }

    ActionCable.server.broadcast(
      "room_#{code}_channel",
      broadcast_data
    )
  end

  def run_tests!
    player1_code = battle_state["player1_code"]
    player2_code = battle_state["player2_code"]

    player1_passed = test_solution(player1_code)
    player2_passed = test_solution(player2_code)

    if player1_passed && !player2_passed
      battle_state.update("winner_id" => users[0].id.to_s)
    elsif player2_passed && !player1_passed
      battle_state.update("winner_id" => users[1].id.to_s)
    end

    update!(status: :completed) if battle_state["winner_id"].present?
  end

  def test_solution(code)
    code.include?('return true')
    update!(status: :completed)
    broadcast_replace_later
    true
  end

  def can_join?
    waiting? && !full?
  end

  private

  def generate_room_code
    self.code ||= SecureRandom.alphanumeric(6).upcase
  end

  def set_default_created_at
    self.created_at ||= Time.current
  end
end
