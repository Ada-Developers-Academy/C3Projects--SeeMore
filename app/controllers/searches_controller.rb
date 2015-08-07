class SearchesController < ApplicationController
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"

  def search
    if params[:search_twitter]
      if params[:search_twitter] == ""
        redirect_to root_path
      else
        redirect_to search_results_path("twitter", params[:search_twitter])
      end
    end

    # OPTIMIZE: refactor so there are less nested if's
    # search via the instagram form
    if params[:search_instagram]
      if params[:search_instagram] == ""
        redirect_to root_path
      else
        redirect_to search_results_path("instagram", params[:search_instagram])
      end
    end
  end

  def show
    if params[:client] == "twitter"
      @search_results = TwitterClient.user_search(params[:search_term])
    elsif params[:client] == "instagram"
      search_results = HTTParty.get(
                        INSTAGRAM_SEARCH_USERS_URI + "q=#{params[:search_term]}")
      @users = search_results["data"]
    end
  end
end
