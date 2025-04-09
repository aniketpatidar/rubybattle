class RoomParticipant < ApplicationRecord
  belongs_to :room
  belongs_to :user

  enum subscription_status: { pending: 0, subscribed: 1, ready: 2 }

  scope :pending, -> { where(subscription_status: :pending) }
  scope :subscribed, -> { where(subscription_status: :subscribed) }
  scope :ready, -> { where(subscription_status: :ready) }

  validates :user_id, uniqueness: { scope: :room_id, message: "can only join a room once" }
  validates :subscription_status, presence: true

  after_initialize :set_default_status, if: :new_record?

  def set_default_status
    self.subscription_status ||= :pending
  end

  def subscribe!
    return if subscribed?
    update!(subscription_status: :subscribed)
    room.broadcast_battle_status if room.can_start_battle?
  end

  def ready!
    update!(subscription_status: :ready)
    room.start_battle! if room.can_start_battle?
  end

  def subscribed?
    subscription_status.in?(['subscribed', 'ready'])
  end
end
