class HomeController < ApplicationController
  def landing_page
    @current_user = User.find(session[:user_id])
  end

  def search
  end

  def twitter_users_redirect
    if params[:user].present?
      redirect_to twitter_users_path(params[:user])
    else
      redirect_to search_path
    end
  end

  def twitter_users
    @user = params[:user]
    @results = @twitter_client.user_search(@user)
    # raise
  end
end
