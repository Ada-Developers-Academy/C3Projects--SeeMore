module ApplicationHelper
  def require_login
    unless session[:user_id]
      redirect_to root_path, flash: { error: MESSAGES[:login_required] }
    end
  end
end
