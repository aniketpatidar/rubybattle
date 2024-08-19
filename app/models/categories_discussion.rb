class CategoriesDiscussion < ApplicationRecord
  belongs_to :category
  belongs_to :discussion
end
