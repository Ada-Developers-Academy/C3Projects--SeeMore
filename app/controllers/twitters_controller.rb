require 'httparty'
require 'twitter'
load 'config/initializers/twitter.rb'

class TwittersController < ApplicationController

  # search page: search for twitter user
  # def search; end

  TWITTER_URI = "https://api.twitter.com/1.1"

  SEARCH_URI = "/users/search.json?"
  # "q=#{username}"

  FEED_URI = "/statuses/user_timeline.json?"
  # "user_id=#{provider_id}&screen_name=#{username}"

  # to refactor into application controller, accepting params
  def twitter_redirect
    if params[:username].present?
      redirect_to search_twitter_path(params[:username])
    else
      redirect_to root_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def search
    @username = params[:username]

    # response = HTTParty.get(TWITTER_URI + SEARCH_URI + "q=#{@username}")

    response = twitter.user_search("#{@username}")

    @response_hash = response

  end

end
