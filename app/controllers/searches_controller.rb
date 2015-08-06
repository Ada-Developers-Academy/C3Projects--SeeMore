class SearchesController < ApplicationController
  TWITTER_SEARCH_URI = "https://api.twitter.com/1.1/users/search.json?"

  def index
    if params[:search_twitter]
      @search_results = @twitter_client.client.user_search("whatever")
    end
  end
end
