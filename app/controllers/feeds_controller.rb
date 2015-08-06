class FeedsController < ApplicationController
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
    @results = @twit_init.client.user_search(@search_term)
  end
end
