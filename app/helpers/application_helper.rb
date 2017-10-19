module ApplicationHelper
  def admin_signed?
    if current_user and current_user.scope == 'admin'
      return true
    end
    return false
  end
end
