class UsersController < ApplicationController
  def index
    online_users = Kredis.unique_list("users_online").elements
    @pagy, @users = pagy(User.search(params), items: 5)
    @active_users, @inactive_users = @users.partition { |user| online_users.include?(user.id.to_s) }
  end

  def show
    @user = User.find_by(slug: params[:slug])
    @users = User.all
    redirect_to root_path, alert: "Sorry unable to find a user for this link #{params[:slug]}" unless @user
  end
end
