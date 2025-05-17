class Challenge < ApplicationRecord
  validates :difficulty, presence: true

  enum difficulty: { easy: 0, medium: 1, hard: 2 }

  def self.search(params)
    params[:query].blank? ? all : where(
      "name LIKE ?", "%#{sanitize_sql_like(params[:query])}%"
    )
  end

  def to_param
    name
  end
end
