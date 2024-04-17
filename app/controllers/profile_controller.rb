class ProfileController < ApplicationController
  def show
    @user = User.find_by(slug: params[:slug])
    redirect_to root_path, alert: "Sorry unable to find a user for this link #{params[:slug]}" unless @user
  end
end
