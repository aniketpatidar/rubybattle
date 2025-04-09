class BattleInvitation < ApplicationRecord
  belongs_to :user
  belongs_to :opponent, class_name: 'User'
  belongs_to :room
  after_create_commit :create_notification

  validates :confirmed, inclusion: { in: [true, false] }

  def create_notification
    BattleInvitationNotification.create!(
      user: opponent,
      params: { 
        user_id: user_id, 
        opponent_id: opponent_id, 
        room_code: room&.code,
        inviter_email: user&.email 
      }
    )
  end
end
