require 'twitter'
require 'twitter_client'
require 'instagram'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :require_signin

  before_action :twitter_client
  # before_filter :load_tweets

  # def load_tweets
  #   @tweets = @twitter_client.user_timeline[0..4] # For this demonstration lets keep the tweets limited to the first 5 available.
  # end

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
end
