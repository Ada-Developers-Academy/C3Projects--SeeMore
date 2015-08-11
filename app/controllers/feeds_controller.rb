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
      @posts.flatten!
    end

    @feed = []
    if @user && @user.tweets
      user_tweets = @user.tweet_posts


    #  usernames = @user.tweets.map &:username
    user_tweets.each do |user_tweet|
      @feed << user_tweet
        #@twitter.client.user_timeline(username)
    end
      # @feed.flatten!
    end

    Struct.new("Ninja", :username, :media_url, :text, :date_time, :avatar, :provider, :link)

    @all_posts = []
    @posts.each do |ig_post|
      username = ig_post["data"]["user"]["username"]
      media_url = InstagramPost.find_by(post_id: ig_post["data"]["id"]).image_url
      date_time = Time.at(ig_post["data"]["created_time"].to_i)
      avatar = nil
      provider = "Instagram"
      link = ig_post["data"]["link"]
      unless ig_post["data"]["caption"].nil?
        text = ig_post["data"]["caption"]["text"]
      else
        text = ""
      end

      @all_posts.push(Struct::Ninja.new(username, media_url, text, date_time, avatar, provider, link))
    end

    @feed.each do |tweet_post|
      # p = TwitterPost.find_by(post_id:
      #username = tweet_post.user.screen_name
      username = tweet_post.tweet.username
      text = tweet_post.text
      date_time = tweet_post.posted_at
      media_url = tweet_post.media_url #tweet_post.profile_image_url(size = :bigger)
      avatar = tweet_post.tweet.image_url
      provider = "Twitter"
      link = nil

      @all_posts.push(Struct::Ninja.new(username, media_url, text, date_time, avatar, provider, link))
    end

    @all_posts.sort_by! { |each_post| each_post.date_time.strftime("%Y-%m-%d %H:%M:%S") }
    @all_posts.reverse!
  end

  def search; end

  def people
    @user = User.includes(:tweets, :instagrams).find(session[:user_id])
    @people = @user.tweets + @user.instagrams
    # @user = User.find_by(id: session[:user_id])
    # if @user
    #   @people = Instagram.find(@user.instagram_ids) +  Tweet.find(@user.tweet_ids)
    # end
  end

end
