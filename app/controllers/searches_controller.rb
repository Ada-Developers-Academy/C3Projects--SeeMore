require 'instagram_client'
class SearchesController < ApplicationController
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
      @prey = InstagramClient.user_search(params[:search_term])
    end
  end
end
