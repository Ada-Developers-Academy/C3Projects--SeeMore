class SearchesController < ApplicationController
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"

  def search
    if params[:search].empty?
      redirect_to root_path
    else
      redirect_to search_results_path(params[:client], params[:search])
    end
  end

  def show
    if params[:client] == "twitter"
      @prey = TwitterClient.user_search(params[:search_term])
    elsif params[:client] == "instagram"
      search_results = HTTParty.get(
                        INSTAGRAM_SEARCH_USERS_URI + "q=#{params[:search_term]}")
      @prey = search_results["data"]
    end
  end
end
