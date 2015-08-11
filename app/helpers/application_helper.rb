module ApplicationHelper

  def user_or_guest
    session[:user_id] ? User.find(session[:user_id]).username : "guest"
  end

end
