class HomeController < ApplicationController

  def index
    if logged_in?
      @posts = @user.posts.order(posted_at: :desc)
    end
  end

  def search
    if params[:search].nil? || params[:search].empty?
      flash[:error] = "Please enter text into the search box."
      redirect_to root_path
    elsif params[:website] == "twitter"
      redirect_to twi_subscriptions_path(params: {twitter_search: params[:search]})
    else
      # when the website is instagram
      redirect_to ig_subscriptions_path(params: {instagram_search: params[:search]})
    end
  end
end
