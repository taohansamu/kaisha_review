module ApplicationHelper
  def admin_signed?
    if current_user and current_user.scope == 'admin'
      return true
    end
    return false
  end
  def resource_name
    :user
  end
 
  def resource
    @resource ||= User.new
  end
 
  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end
end
