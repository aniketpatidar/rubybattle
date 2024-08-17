class PagesController < ApplicationController
  def home
  end

  def dashboard
    users_online = Kredis.unique_list("users_online").elements
    @pagy, @users = pagy(User.search(params), items: 5)
    @active_users, @inactive_users = @users.partition { |user| users_online.include?(user.id.to_s) }
  end
end
