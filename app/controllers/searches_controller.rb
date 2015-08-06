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

    # search via the instagram form
    # if params[:search_instagram]
    #   if params[:search_instagram] == ""
    #     redirect_to root_path
    #   else
    #     redirect_to search_results_path("instagram", params[:search_instagram])
    #   end
    # end
  end

  def show
    if params[:client] == "twitter"
      @search_results = @twitter_client.client.user_search(params[:search_term])
    elsif params[:client] == "instagram"
      # put code for instagram search results here
    end
  end
end
