class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  has_many :posts, dependent: :destroy
  validates :slug, uniqueness: true
  before_validation :set_slug, if: -> { slug.nil? }

  has_many :invitations
  has_many :pending_invitations, -> { where confirmed: false }, class_name: 'Invitation', foreign_key: "friend_id"
  has_many :notifications, dependent: :destroy
  has_many :discussions, dependent: :destroy
  has_many :challenge_completions, dependent: :destroy
  acts_as_voter

  def friends
    sent     = Invitation.where(user_id: id, confirmed: true).select(:friend_id)
    received = Invitation.where(friend_id: id, confirmed: true).select(:user_id)
    User.where(id: sent).or(User.where(id: received))
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
    [first_name[0].upcase, last_name[0].upcase].join
  end

  def self.search(params)
    params[:query].blank? ? all : where(
      "slug LIKE ?", "%#{sanitize_sql_like(params[:query])}%"
    )
  end

  def to_param
    slug
  end

  def admin?
    id == 1
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
