class Discussion < ApplicationRecord
  include VotesCountable

  belongs_to :user, default: -> { Current.user }
  has_many :posts, dependent: :destroy
  has_rich_text :description
  validates :name, presence: { message: "Please provide a title for your problem." }
  validates :description, presence: { message: "Please provide the details of your problem." }

  accepts_nested_attributes_for :posts, reject_if: ->(attributes) { attributes['body'].blank? }

  after_create_commit -> { broadcast_prepend_to "discussions" }
  after_update_commit -> { broadcast_replace_to "discussions" }
  after_destroy_commit -> { broadcast_remove_to "discussions" }

  acts_as_votable

  def to_param
    "#{id}-#{name.downcase.to_s[0...100]}".parameterize
  end

  def upvote!(user)
    if user.voted_up_on? self, vote_scope: 'like'
      unvote_by user, vote_scope: 'like'
    else
      upvote_by user, vote_scope: 'like'
    end
  end

  def downvote!(user)
    if user.voted_down_on? self, vote_scope: 'like'
      unvote_by user, vote_scope: 'like'
    else
      downvote_by user, vote_scope: 'like'
    end
  end
end
