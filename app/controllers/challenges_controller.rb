class ChallengesController < ApplicationController
  before_action :load_challenge, only: %i[show room]

  def index
    @pagy, @challenges = pagy(Challenge.search(params), items: 5)
  end

  def show
    @room_id = SecureRandom.uuid
  end

  def room
    @room_id = params[:room_id]
    # …load any session‐specific metadata…
  end

  private

  def load_challenge
    @challenge = Challenge.find_by!(name: params[:name])
  end
end
