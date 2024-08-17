class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_many :posts, dependent: :destroy
  has_rich_text :description
  validates :name, presence: { message: "Please provide a title for your problem." }
  validates :description, presence: { message: "Please provide the details of your problem." }

  accepts_nested_attributes_for :posts, reject_if: ->(attributes) { attributes['body'].blank? }

  after_create_commit -> { broadcast_prepend_to "discussions" }
  after_update_commit -> { broadcast_replace_to "discussions" }
  after_destroy_commit -> { broadcast_remove_to "discussions" }

  def to_param
    "#{id}-#{name.downcase.to_s[0...100]}".parameterize
  end
end
