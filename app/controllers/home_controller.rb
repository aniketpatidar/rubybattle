class HomeController < ApplicationController
  def index
    @room_id, challenge_id = params[:room_id].split("--")
    if challenge_id
      @challenge = Challenge.find(challenge_id)
    else
      @challenge = Challenge.order('RANDOM()').first
    end
  end
end
