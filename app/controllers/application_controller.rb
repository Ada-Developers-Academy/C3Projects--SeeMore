require 'twitter'
require 'twitter_client'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :twitter_client
  before_filter :load_tweets

  def load_tweets
    @tweets = @twitter_client.client.user_timeline[0..4] # For this demonstration lets keep the tweets limited to the first 5 available.
  end

  def twitter_client
    @twitter_client ||= TwitterClient.new
  end
end
