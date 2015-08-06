class SearchesController < ApplicationController
  TWITTER_SEARCH_URI = "https://api.twitter.com/1.1/users/search.json?"

  def index
    if params[:search_twitter]
      if params[:search_twitter] == ""
        redirect_to root_path
      else
        redirect_to search_results_path("twitter", params[:search_twitter])
      end
    end
  end

  def show
    if params[:client] == "twitter"
      @search_results = @twitter_client.client.user_search(params[:search_term])
    end
  end
end
