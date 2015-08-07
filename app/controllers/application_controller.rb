require 'twitter'
require 'twit'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :twit

  MESSAGES = {
    no_username: "There's no user by that name. Search again.",
    following_person: "You're now following #{@person}!",
    follow_error: "Oops. Something went wrong.",
    login_required: "You have to be logged in to do that!"
  }

  def twit
    @twitter ||= Twit.new
  end

  def require_login
    unless session[:user_id]
      redirect_to root_path, flash: { error: MESSAGES[:login_required] }
    end
  end
end
