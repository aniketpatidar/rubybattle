class Challenge < ApplicationRecord
  validates :difficulty, presence: true

  enum difficulty: {
    easy: 0,
    medium: 1,
    hard: 2,
    expert: 3
  }

  def difficulty_badge_color
    case difficulty.to_sym
    when :easy
      'bg-green-100 text-green-800'
    when :medium
      'bg-yellow-100 text-yellow-800'
    when :hard
      'bg-orange-100 text-orange-800'
    when :expert
      'bg-red-100 text-red-800'
    end
  end

  def method_name
    method_template.match(/def\s+(\w+)\s*\(/)[1]
  end

  def default_duration
    case difficulty.to_sym
    when :easy
      10.minutes
    when :medium
      15.minutes
    when :hard
      20.minutes
    when :expert
      25.minutes
    else
      15.minutes
    end
  end
end
