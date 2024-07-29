class Discussion < ApplicationRecord
  belongs_to :user, default: -> { Current.user }
  has_rich_text :description
  validates :name, presence: true
  validates :description, presence: true
end
