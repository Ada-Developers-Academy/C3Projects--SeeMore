require 'twitter'
require 'twitter_client'
require 'instagram'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :require_signin
  before_action :twitter_client

  TWITTER = "twitter"
  INSTAGRAM = "instagram"

  private

  Instagram.configure do |config|
    config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
    config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
  end

  def twitter_client
    @twitter_client ||= TwitterClient.new.client
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def require_signin
    unless @current_user
      # flash[:errors] = MESSAGES[:not_signed_in]
      redirect_to signin_path
    end
  end

  def convert_instagram_time(time)
    Time.at(time.to_i)
  end
end
