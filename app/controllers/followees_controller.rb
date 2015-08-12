class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  USER_COUNT = 3

  INSTA_USER_DETAILS_URI = "https://api.instagram.com/v1/users/"

  before_action :find, only: [:destroy]
  # helper_method :get_embedded_html_instagram
  helper_method :private_user?

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
    case params[:source]
    when INSTAGRAM
      response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&count=" + USER_COUNT.to_s + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
      @results = response["data"]
    when TWITTER
      @results = @twitter_client.user_search(@query, { count: USER_COUNT })
    end

    render 'search'
  end

  def private_user?(user_id)
    response = HTTParty.get(INSTA_USER_DETAILS_URI + "#{user_id}" + "/relationship?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    privacy_boolean = response["data"]["target_user_is_private"]

    return privacy_boolean
  end
end
