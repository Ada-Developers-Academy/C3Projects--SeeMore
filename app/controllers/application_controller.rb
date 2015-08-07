class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

    def twitter_api_object
      Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CLIENT_ID"]
        config.consumer_secret     = ENV["TWITTER_CLIENT_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
    end
  end
