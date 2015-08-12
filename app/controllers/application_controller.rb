# include these gems to work with social media APIs
require 'twitter'
require 'instagram'

# include the below classes to keep api logic modular
require 'twitter_api'
require 'instagram_api'
require 'instagram_mapper'
require 'twitter_mapper'
require 'api_helper'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :current_user
  before_action :require_signin

  TWITTER = "twitter"
  INSTAGRAM = "instagram"

  private

  Instagram.configure do |config|
    config.client_id = ENV["INSTAGRAM_CLIENT_ID"]
    config.client_secret = ENV["INSTAGRAM_CLIENT_SECRET"]
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
end
