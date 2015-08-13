module ApplicationHelper
  def logged_in?
    unless session[:user_id].blank?
      return true
    end
  end
end
