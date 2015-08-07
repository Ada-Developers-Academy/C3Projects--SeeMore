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
  # def instagram_users_redirect
  #   # was 'users_redirect'
  #   @query = params[:search]
  #   response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
  #   @insta_users = response["data"]
  # end

  def instagram_users_redirect
    if params[:user].present?
      redirect_to search_results_path(params[:source], params[:user])
    else
      flash[:errors] = "Please enter a username."
      redirect_to search_final_path
    end
  end

  def twitter_users_redirect
    if params[:user].present?
      redirect_to search_results_path(params[:source], params[:user])
    else
      flash[:errors] = "Please enter a username."
      redirect_to search_final_path
    end
  end

  # this displays results
  def search_results
    # raise
    @query = params[:user]
    @source = params[:source]
    if params[:source] == "instagram"
      response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
      @results = response["data"]
    elsif params[:source] == "twitter"
      @results = @twitter_client.user_search(@query)
    end
    render 'search'
  end

  # pull a user's instagram posts
  def insta_user_posts 
    # will need to update this @user_id variable when we no longer are using a route to set params[:user] here
    @user_id = params[:user]
    response = HTTParty.get(INSTA_USER_POSTS_URI + @user_id + "/media/recent/?count=3&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
  
    @insta_user_posts = response["data"]
  end


  def twitter_users
    @user = params[:user]
    @results = @twitter_client.user_search(@user)
    # raise
  end

  # def insta_search; end

  def search
    # raise
  end 

###########################################
  private

  def find
    @followees = [User.find(session[:user_id]).followees]
  end

  def followee_params
    params.require(:followee).permit(:handle, :source, :avatar_url)
  end

end
