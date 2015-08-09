require 'twit'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"
  MESSAGES = {
    no_username: "There's no user by that name. Search again.",
    success: "Success!",
    follow_error: "Oops. Something went wrong.",
    login_required: "You have to be logged in to do that!"
  }

  def require_login
    unless session[:user_id]
      redirect_to root_path, flash: { error: MESSAGES[:login_required] }
    end
  end
end
