class SearchesController < ApplicationController
  TWITTER_SEARCH_URI = "https://api.twitter.com/1.1/users/search.json?"

  def index
    if params[:search_twitter]
      @search_twitter = params[:search_twitter]
      response = HTTParty.get(TWITTER_SEARCH_URI + "q=#{@search_twitter}")
      # user_matches = Twitter.search_user(params[:search_twitter])
      raise
    end
  end
end
