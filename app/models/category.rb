class Category < ApplicationRecord
  has_many :categories_discussions
  has_many :discussions, through: :categories_discussions, counter_cache: true
end
