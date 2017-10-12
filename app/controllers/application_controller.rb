class ApplicationController < ActionController::Base
  layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?  
  protect_from_forgery with: :exception
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
  end
  private
  
  def layout_by_resource
    if devise_controller?
      "login"
    else
      "application"
    end
  end
end
