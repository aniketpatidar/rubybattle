class Invitation < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'
  after_create_commit :create_notification

  def self.reacted?(id1, id2)
    where("(user_id = :a AND friend_id = :b) OR (user_id = :b AND friend_id = :a)", a: id1, b: id2).exists?
  end

  def self.confirmed_record?(id1, id2)
    where("(user_id = :a AND friend_id = :b) OR (user_id = :b AND friend_id = :a)", a: id1, b: id2)
      .where(confirmed: true).exists?
  end

  def self.find_invitation(id1, id2)
    where("(user_id = :a AND friend_id = :b) OR (user_id = :b AND friend_id = :a)", a: id1, b: id2)
      .where(confirmed: true)
      .pick(:id)
  end

  def create_notification
    InvitationNotification.create(user: friend, params: { user_id: user.id, friend_id: friend.id, first_name: user.first_name, slug: user.slug })
  end
end
