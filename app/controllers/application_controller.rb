class ApplicationController < ActionController::Base
  include Pagy::Backend
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:update, keys: %i[first_name last_name])
    devise_parameter_sanitizer.permit(:invite, keys: [:first_name, :last_name])
  end
end
