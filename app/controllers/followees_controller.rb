class FolloweesController < ApplicationController
  USER_COUNT = 3

  INSTA_USER_DETAILS_URI = "https://api.instagram.com/v1/users/"

  before_action :find, only: [:destroy]
  # helper_method :get_embedded_html_instagram
  helper_method :private_user?, :currently_following?, :find_subscription_id

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
    @results = Followee.user_search(@query, USER_COUNT, @source)

    render 'search'
  end

  def private_user?(user_id)
    response = HTTParty.get(INSTA_USER_DETAILS_URI + "#{user_id}" + "/relationship?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    privacy_boolean = response["data"]["target_user_is_private"]

    return privacy_boolean
  end

  def currently_following?(native_id)
    followee = find_followee(native_id)
    if followee
      @current_user.subscriptions.active_for_this_followee(followee.id).empty? ? false : true
    else
      return false
    end
  end

  def find_subscription_id(native_id)
    followee = find_followee(native_id)
    subscription_id_to_unsubscribe = @current_user.subscriptions.active_for_this_followee(followee.id).first
  end

  def find_followee(native_id)
    Followee.find_by(native_id: native_id)
  end
end
