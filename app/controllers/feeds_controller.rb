class FeedsController < ApplicationController

  def search; end

  def search_redirect
    if params[:search_term].present?
      redirect_to search_results_path
    else
      redirect_to search_path
    end
  end

  def search_results

    #Actual stuff

  end

end
