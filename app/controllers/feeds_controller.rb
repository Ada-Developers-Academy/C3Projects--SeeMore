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
      usernames = @user.tweets.map &:username
      usernames.each do |username|
        @feed << @twitter.client.user_timeline(username)
      end
      @feed.flatten!
    end

    Struct.new("Ninja", :username, :photo, :text, :date_time, :avatar, :provider, :link)

    @all_posts = []
    @posts.each do |ig_post|
      username = ig_post["data"]["user"]["username"]
      photo = ig_post["data"]["images"]["standard_resolution"]["url"]
      date_time = Time.at(ig_post["data"]["created_time"].to_i)
      avatar = nil
      provider = "Instagram"
      link = ig_post["data"]["link"]
      unless ig_post["data"]["caption"].nil?
        text = ig_post["data"]["caption"]["text"]
      else
        text = ""
      end

      @all_posts.push(Struct::Ninja.new(username, photo, text, date_time, avatar, provider, link))
    end

    @feed.each do |tweet_post|
      username = tweet_post.user.screen_name
      text = tweet_post.text
      date_time = tweet_post.created_at
      photo = nil #tweet_post.profile_image_url(size = :bigger)
      avatar = nil
      provider = "Twitter"
      link = nil

      @all_posts.push(Struct::Ninja.new(username, photo, text, date_time, avatar, provider, link))
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
