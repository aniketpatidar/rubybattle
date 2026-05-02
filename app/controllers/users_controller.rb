class UsersController < ApplicationController
  def index
    online_users = Kredis.unique_list("users_online").elements
    @pagy, @users = pagy(User.search(params), items: 5)
    @active_users, @inactive_users = @users.partition { |user| online_users.include?(user.id.to_s) }
  end

  def show
    @user = User.find_by(slug: params[:slug])
    redirect_to root_path, alert: "Sorry unable to find a user for this link #{params[:slug]}" and return unless @user
    @game_history = Game.where("challenger_id = :id OR opponent_id = :id", id: @user.id)
                        .where(status: Game.statuses[:completed])
                        .includes(:challenger, :opponent, :winner, game_rounds: :challenge)
                        .order(completed_at: :desc)
                        .limit(10)
  end
end
