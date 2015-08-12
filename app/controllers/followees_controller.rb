class FolloweesController < ApplicationController
  USER_COUNT = 3

  before_action :find, only: [:destroy]

  include ActionView::Helpers::OutputSafetyHelper

  def search; end   # this renders the search page

  def instagram_users_redirect
    if params[:user].present?
      redirect_to search_results_path(params[:source], params[:user])
    else
      flash[:errors] = "Please enter a username."
      redirect_to search_path
    end
  end

  def twitter_users_redirect
    if params[:user].present?
      redirect_to search_results_path(params[:source], params[:user])
    else
      flash[:errors] = "Please enter a username."
      redirect_to search_path
    end
  end

  # this displays results on the search page
  def search_results
    @query = params[:user]
    @source = params[:source]

    # call a ApiHelper class method that directs the flow to the correct Api
    @results = ApiHelper.user_search(@query, USER_COUNT, @source)

    render 'search'
  end
end
