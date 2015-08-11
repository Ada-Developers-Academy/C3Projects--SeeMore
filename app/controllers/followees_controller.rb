class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  USER_COUNT = 3

  before_action :find, only: [:destroy]
  helper_method :get_embedded_html_instagram

  include ActionView::Helpers::OutputSafetyHelper

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

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

###########################################
  private
  def find
    @followees = [@current_user.followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
