class PagesController < ApplicationController
  def home
  end

  def dashboard
    users_online = Kredis.unique_list("users_online").elements
    @active_users = User.where(id: users_online)
    @inactive_users = User.where.not(id: users_online)
  end
end
