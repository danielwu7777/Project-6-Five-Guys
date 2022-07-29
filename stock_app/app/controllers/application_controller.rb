class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Created 7/26/22 by Noah Moon
  # Edited 7/26/2022 by Daniel Wu: Added fname and lname
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:fname, :lname, :liquidcash])
    devise_parameter_sanitizer.permit(:account_update, keys: [:fname, :lname, :email, :password, :current_password])
  end
end
