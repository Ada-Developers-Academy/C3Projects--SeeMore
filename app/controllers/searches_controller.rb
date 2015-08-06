class SearchesController < ApplicationController
  def index
    if params[:search_twitter]
      if params[:search_twitter] == ""
        redirect_to root_path
      else
        redirect_to search_results_path("twitter", params[:search_twitter])
      end
    end

    # OPTIMIZE: refactor so there are less nested if's
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
      @search_results = TwitterClient.user_search(params[:search_term])
    elsif params[:client] == "instagram"
      # TODO: put code to search instagram users here
    end
  end
end
