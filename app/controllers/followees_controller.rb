class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  before_action :find, only: [:destroy]

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

  def users_redirect
    @query = params[:search]
    response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    @insta_users = response["data"]
  end

  # search for users by name
  def insta_search
    # @results = []
    # for user in client.user_search("instagram")
      # @results << user
    # end
    # @results
  end

  private

  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
