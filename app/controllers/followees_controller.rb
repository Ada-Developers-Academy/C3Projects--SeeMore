class FolloweesController < ApplicationController
  USER_COUNT = 3

  # INSTA_USER_DETAILS_URI = "https://api.instagram.com/v1/users/"

  before_action :find, only: [:destroy]
  # helper_method :get_embedded_html_instagram
  helper_method :private_user?, :already_following?

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


  def already_following?(followee_id)
    @current_user.followees.find_by(native_id: followee_id) ? true : false
  end
end
