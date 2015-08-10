class FolloweesController < ApplicationController
  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  INSTA_USER_COUNT = "3"

  TWIT_URI = "https://api.twitter.com/1.1/statuses/user_timeline.json?"
  
  before_action :find, only: [:destroy]
  helper_method :get_embedded_html_instagram

  include ActionView::Helpers::OutputSafetyHelper

  def new
    @followee = Followee.new
  end

  def create; end

  def destroy; end

  # this renders the search page
  def search; end

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
    if params[:source] == "instagram"
      response = HTTParty.get(INSTA_URI + "q=#{@query}" + "&count=" + INSTA_USER_COUNT + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
      @results = response["data"]
    elsif params[:source] == "twitter"
      @results = @twitter_client.user_search(@query)
    end
    render 'search'
  end

  # pull a user's instagram posts
  def insta_posts
    # will need to update this @user_id variable when we no longer are using a route to set params[:user] here
    @followee = params[:followee]
    response = HTTParty.get(INSTA_USER_POSTS_URI + @followee + "/media/recent/?count=3&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])

    @insta_posts = response["data"]
    link = @insta_posts.first["link"]
  
    @instagram_html = get_embedded_html_instagram(link)

    # EXAMPLE EMBEDDED JSON OBJECT FORMAT = {
    #   "provider_url"=>"https://instagram.com/", 
    #   "media_id"=>"1037200603677204145_6", 
    #   "author_name"=>"nicole", 
    #   "height"=>nil, 
    #   "provider_name"=>"Instagram", 
    #   "title"=>"Dear Tahoe, \nYou are wonderful. \nLove, Nico", 
    #   "html"=>"<blockquote class=\"instagram-media\" data-instgrm-captioned data-instgrm-version=\"4\" style=\" background:#FFF; border:0; border-radius:3px; box-shadow:0 0 1px 0 rgba(0,0,0,0.5),0 1px 10px 0 rgba(0,0,0,0.15); margin: 1px; max-width:658px; padding:0; width:99.375%; width:-webkit-calc(100% - 2px); width:calc(100% - 2px);\"><div style=\"padding:8px;\"> <div style=\" background:#F8F8F8; line-height:0; margin-top:40px; padding:50% 0; text-align:center; width:100%;\"> <div style=\" background:url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACwAAAAsCAMAAAApWqozAAAAGFBMVEUiIiI9PT0eHh4gIB4hIBkcHBwcHBwcHBydr+JQAAAACHRSTlMABA4YHyQsM5jtaMwAAADfSURBVDjL7ZVBEgMhCAQBAf//42xcNbpAqakcM0ftUmFAAIBE81IqBJdS3lS6zs3bIpB9WED3YYXFPmHRfT8sgyrCP1x8uEUxLMzNWElFOYCV6mHWWwMzdPEKHlhLw7NWJqkHc4uIZphavDzA2JPzUDsBZziNae2S6owH8xPmX8G7zzgKEOPUoYHvGz1TBCxMkd3kwNVbU0gKHkx+iZILf77IofhrY1nYFnB/lQPb79drWOyJVa/DAvg9B/rLB4cC+Nqgdz/TvBbBnr6GBReqn/nRmDgaQEej7WhonozjF+Y2I/fZou/qAAAAAElFTkSuQmCC); display:block; height:44px; margin:0 auto -44px; position:relative; top:-22px; width:44px;\"></div></div> <p style=\" margin:8px 0 0 0; padding:0 4px;\"> <a href=\"https://instagram.com/p/5k4HQnAB6x/\" style=\" color:#000; font-family:Arial,sans-serif; font-size:14px; font-style:normal; font-weight:normal; line-height:17px; text-decoration:none; word-wrap:break-word;\" target=\"_top\">Dear Tahoe, You are wonderful. Love, Nico</a></p> <p style=\" color:#c9c8cd; font-family:Arial,sans-serif; font-size:14px; line-height:17px; margin-bottom:0; margin-top:8px; overflow:hidden; padding:8px 0 7px; text-align:center; text-overflow:ellipsis; white-space:nowrap;\">A photo posted by Nicole Schuetz (@nicole) on <time style=\" font-family:Arial,sans-serif; font-size:14px; line-height:17px;\" datetime=\"2015-07-25T22:39:28+00:00\">Jul 25, 2015 at 3:39pm PDT</time></p></div></blockquote>\n<script async defer src=\"//platform.instagram.com/en_US/embeds.js\"></script>", 
    #   "width"=>658, 
    #   "version"=>"1.0", 
    #   "author_url"=>"https://instagram.com/nicole", 
    #   "author_id"=>6, 
    #   "type"=>"rich"
    # } 
  end

  def get_embedded_html_instagram(link)
    HTTParty.get(INSTA_OEMBED_URI + link)["html"]
  end

  # pull twitter posts
  def twitter_posts
    @followee = params[:followee]
    @twit_user_posts = @twitter_client.user_timeline(@followee)
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
