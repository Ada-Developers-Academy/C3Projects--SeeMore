require 'twit'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # rescue_from SQLite3::ConstraintException, with: :already_following unless Rails.env.production?
  before_filter :twit

  INSTAGRAM_URI = "https://api.instagram.com/v1/"
  MESSAGES = {
    no_username: "There's no user by that name. Search again.",
    success: "Success!",
    follow_error: "Oops. Something went wrong.",
    login_required: "You have to be logged in to do that!",
    target_eliminated: "Target eliminated!",
    already_following_error: "Oops! You are already following that person."
  }

  def twit
    @twitter ||= Twit.new
  end

  private

  def require_login
    unless session[:user_id]
      redirect_to root_path, flash: { error: MESSAGES[:login_required] }
    end
  end

  def already_following
    params[:instagram] = nil
    params[:tweet] = nil

    flash.now[:error] = MESSAGES[:already_following_error]
    render "feeds/search"
  end



end
