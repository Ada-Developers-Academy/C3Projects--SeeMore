require 'instagram_client'
class SearchesController < ApplicationController
  def search
    if params[:search_twitter]
      if params[:search_twitter].empty?
        redirect_to root_path
      else
        redirect_to search_results_path("twitter", params[:search_twitter])
      end
    end

    # OPTIMIZE: refactor so there are less nested if's
    # search via the instagram form
    if params[:search_instagram]
      if params[:search_instagram].empty?
        redirect_to root_path
      else
        redirect_to search_results_path("instagram", params[:search_instagram])
      end
    end
  end

  def show
    if params[:client] == "twitter"
      @prey = TwitterClient.user_search(params[:search_term])
    elsif params[:client] == "instagram"
      @prey = InstagramClient.user_search(params[:search_term])
    end
  end
end
