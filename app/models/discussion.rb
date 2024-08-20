class Discussion < ApplicationRecord
  include VotesCountable

  belongs_to :user, default: -> { Current.user }
  has_many :posts, dependent: :destroy
  has_many :categories_discussions
  has_many :categories, through: :categories_discussions
  has_rich_text :description

  validates :name, presence: { message: "Please provide a title for your problem." }
  validates :description, presence: { message: "Please provide the details of your problem." }

  accepts_nested_attributes_for :posts, reject_if: ->(attributes) { attributes['body'].blank? }

  after_create_commit -> { broadcast_prepend_to "discussions" }
  after_update_commit -> { broadcast_replace_to "discussions" }
  after_destroy_commit -> { broadcast_remove_to "discussions" }

  acts_as_votable

  scope :ordered_by_votes, -> { sort_by(&:total_vote_count).reverse }

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

  def self.search(params)
    return all if params[:query].blank?

    joins(:rich_text_description)
      .where("discussions.name LIKE :query OR action_text_rich_texts.body LIKE :query", query: "%#{sanitize_sql_like(params[:query])}%")
  end
end
