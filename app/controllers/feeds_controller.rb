class FeedsController < ApplicationController

  TWITTER_URI = "https://api.twitter.com/1.1/users/search.json?q="

  def search; end

  def search_redirect
    if params[:search_term].present?
      redirect_to search_results_path(params[:search_term])
    else
      redirect_to search_path
    end
  end

  def search_results
    @search_term = params[:search_term]
    @results = HTTParty.get(TWITTER_URI + "#{@search_term}")
  end

end
