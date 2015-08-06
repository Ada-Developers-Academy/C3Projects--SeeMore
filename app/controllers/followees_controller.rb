class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  before_action :find, only: [:destroy]

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

  def insta_users; end

  # search for users by name
  def insta_search
    client = Instagram.client(:access_token => session[:access_token])
    # @search = params[:search]
    @results = []
    for user in client.user_search("instagram")
      @results << user
    end
    @results

    # response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=ACCESS-TOKEN")
    # @insta_users = response["search"]
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

  private

  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
