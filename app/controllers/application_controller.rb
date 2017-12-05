class ApplicationController < ActionController::Base
  # layout :layout_by_resource
  before_action :configure_permitted_parameters, if: :devise_controller?  
  protect_from_forgery with: :exception
  helper_method :authenticate_admin
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit :sign_up, keys: [:username]
    devise_parameter_sanitizer.permit :account_update, keys: [:username, :avatar]
end
private

# def layout_by_resource
#   if devise_controller?
#     "login"
#   else
#     "application"
#   end
# end
  def authenticate_admin
    if current_user and current_user.scope == 'admin'
      return true
    end
    flash[:error] = 'Adminだけ、この機能使える！'
    redirect_to root_path
  end
end