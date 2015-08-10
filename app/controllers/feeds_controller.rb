require 'httparty'

class FeedsController < ApplicationController
  before_action :require_login, only: [:people]

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
      # @people = []
      # # will eventually combine Instagram and Twitter feeds into one, then sort both together by posted_at time
      # # @people << Instagram.find(@user.instagram_ids)
      # @people << Tweet.find(@user.tweet_ids)
      # @people.flatten!

      @feed = []
      # @people.each do |person|
      usernames = @user.tweets.map &:username
      usernames.each do |username|
        # username = person.username
        @feed << Twit.user_timeline(username)
        # raise

      end
      # raise
      @feed.flatten!
      @feed.sort_by! { |tweet| tweet.created_at.strftime("%Y-%m-%d %H:%M:%S") }
      @feed.reverse!
    end
  end

  def search; end

  def people
    # if @user
    @user = User.includes(:tweets, :instagrams).find(session[:user_id])
    @people = @user.tweets + @user.instagrams
    # end

    # @user = User.find_by(id: session[:user_id])
    # if @user
    #   @people = Instagram.find(@user.instagram_ids) +  Tweet.find(@user.tweet_ids)
    # end
  end

end
