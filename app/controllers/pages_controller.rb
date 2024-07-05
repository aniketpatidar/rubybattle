class PagesController < ApplicationController
  def home
  end

  def dashboard
    @users = User.all
  end
end
