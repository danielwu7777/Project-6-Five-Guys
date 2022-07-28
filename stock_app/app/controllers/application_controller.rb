class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :add_signup_params, if: :devise_controller?

  protected

  # Created 7/26/22 by Noah Moon
  def add_signup_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:liquidcash])
  end
end
