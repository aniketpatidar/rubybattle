class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @challenges_solved = current_user.challenge_completions.count
    @friends = current_user.friends
    @featured_challenges = Challenge.order(:difficulty).limit(3)

    @new_user    = @friends.empty? && @challenges_solved.zero?
    @leaderboard = User.top_10_by_score
  end
end
