class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  before_action :find, only: [:destroy]

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

  # search for users by name
  def insta_users
    @search = params[:search]
    response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=ACCESS-TOKEN")
    @insta_users = response["search"]
    # search output----------------
    # {
    #   "data": [{
    #       "username": "jack",
    #       "first_name": "Jack",
    #       "profile_picture": "http://distillery.s3.amazonaws.com/profiles/profile_66_75sq.jpg",
    #       "id": "66",
    #       "last_name": "Dorsey"
    #   }} ------------------------
  end

  # pull a user's instagram posts
  def insta_user_posts 
    user_id = "66"
    response = HTTParty.get(INSTA_USER_POSTS_URI + user_id + "/media/recent/?access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])


  end

  private

  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
