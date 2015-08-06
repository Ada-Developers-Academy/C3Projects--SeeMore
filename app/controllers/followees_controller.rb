class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"

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

end
