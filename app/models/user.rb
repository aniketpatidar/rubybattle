class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :posts
  validates :slug, uniqueness: true
  before_validation :set_slug, if: -> { slug.nil? }

  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: "friend_id"
  has_many :notifications, dependent: :destroy
  has_many :discussions, dependent: :destroy

  def friends
    friends_i_sent_invitation = Invitation.where(user_id: id, confirmed: true).pluck(:friend_id)
    friends_i_got_invitation = Invitation.where(friend_id: id, confirmed: true).pluck(:user_id)
    ids = friends_i_sent_invitation + friends_i_got_invitation
    User.where(id: ids)
  end

  def friend_with?(user)
    Invitation.confirmed_record?(id, user.id)
  end

  def send_invitation(user)
    invitations.create(friend_id: user.id)
  end

  def sent_invitations
    Invitation.where(user_id: id, confirmed: false)
  end

  def received_invitations
    Invitation.where(friend_id: id, confirmed: false)
  end

  def full_name
    [first_name, last_name].join(' ')
  end

  def initials
    [first_name[0], last_name[0]].join()
  end

  private

  def set_slug
    if User.find_by(slug: full_name.parameterize)
      self.slug = full_name.parameterize + SecureRandom.hex(6)
    else
      self.slug = full_name.parameterize
    end
  end
end
