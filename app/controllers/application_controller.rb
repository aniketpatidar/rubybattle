class ApplicationController < ActionController::Base
  include CableReady::Broadcaster
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_user, if: :user_signed_in?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :slug, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:first_name, :last_name, :slug, :avatar])
  end

  private

  def set_current_user
    Current.user = current_user
  end
end
