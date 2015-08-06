require 'twitter_client'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :set_twitter_client

  def set_twitter_client
    @twitter_client ||= TwitterClient.new
  end
end
