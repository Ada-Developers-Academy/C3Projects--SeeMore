class FolloweesController < ApplicationController
  USER_COUNT = 3

  helper_method :find_subscription_id
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
    @results = ApiHelper.user_search(@query, USER_COUNT, @source)

    render 'search'
  end

  def find_subscription_id(native_id)
    followee = find_followee(native_id)
    subscription_id_to_unsubscribe = @current_user.subscriptions.active_for_this_followee(followee.id).first
  end

  def find_followee(native_id)
    Followee.find_by(native_id: native_id)
  end

end
