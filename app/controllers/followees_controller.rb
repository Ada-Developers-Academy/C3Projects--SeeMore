class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  TWIT_URI = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
  before_action :find, only: [:destroy]

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

# Instagram -------------------------------------------
  # search for users by name
  def users_redirect
    @query = params[:search]
    response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    @insta_users = response["data"]
  end

  # pull a user's instagram posts
  def insta_user_posts
    # will need to update this @user_id variable when we no longer are using a route to set params[:user] here
    @user_id = params[:user]
    response = HTTParty.get(INSTA_USER_POSTS_URI + @user_id + "/media/recent/?count=3&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])

    @insta_user_posts = response["data"]
  end

  def insta_search; end

# Twitter -------------------------------------------------

  # pull twitter posts
  def twitter_posts
    @followee = params[:followee]
    @twit_user_posts = @twitter_client.user_timeline(@followee)
  end
  private
# ---------------------------------------------------------
  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
