require 'httparty'

class FeedsController < ApplicationController
  before_action :require_login, only: [:people, :search]

  def index
    @user = User.find_by(id: session[:user_id])
    @posts = []
    if @user && @user.instagrams
      @user.instagram_posts.each do |post|
        @posts << HTTParty.get(INSTAGRAM_URI + "media/" + post.post_id + "?access_token=#{session[:access_token]}")
      end
      @posts.sort_by! { |post| post["data"]["created_time"]}
      @posts.reverse!
    end

    if @user && @user.tweets

      @feed = []
      usernames = @user.tweets.map &:username
      usernames.each do |username|
        @feed << @twitter.client.user_timeline(username)
      end

      @feed.flatten!
      @feed.sort_by! { |tweet| tweet.created_at.strftime("%Y-%m-%d %H:%M:%S") }
      @feed.reverse!
    end
  end

  def search; end

  def people
    @user = User.includes(:tweets, :instagrams).find(session[:user_id])
    @people = @user.tweets + @user.instagrams
  end

end
