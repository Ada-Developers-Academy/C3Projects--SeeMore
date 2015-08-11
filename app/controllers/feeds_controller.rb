require 'httparty'

class FeedsController < ApplicationController
  before_action :require_login, only: [:people, :search]
  before_action :instagram_post_create, only: [:index]
  before_action :tweet_post_create, only: [:index]

  def index
    @user = User.find_by(id: session[:user_id])

    @ig_feed = []
    if @user && @user.instagrams
      @user.instagram_posts.each do |post|
        @ig_feed << HTTParty.get(INSTAGRAM_URI + "media/" + post.post_id + "?access_token=#{session[:access_token]}")
      end
      @ig_feed.flatten!
    end

    @tweet_feed = []
    if @user && @user.tweets
      user_tweets = @user.tweet_posts
      user_tweets.each do |user_tweet|
        @tweet_feed << user_tweet
      end
    end

    Struct.new("Ninja", :username, :media_url, :text, :date_time, :avatar, :provider, :link)

    @all_posts = []
    @ig_feed.each do |ig_post|
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

    @tweet_feed.each do |tweet_post|
      username = tweet_post.tweet.username
      text = tweet_post.text
      date_time = tweet_post.posted_at
      media_url = tweet_post.media_url
      avatar = tweet_post.tweet.image_url
      provider = "Twitter"
      link = nil

      @all_posts.push(Struct::Ninja.new(username, media_url, text, date_time, avatar, provider, link))
    end

    @all_posts.sort_by! { |each_post| each_post.date_time.strftime("%Y-%m-%d %H:%M:%S") }
    @all_posts.reverse!
  end

  def people
    @user = User.includes(:tweets, :instagrams).find(session[:user_id])
    @people = @user.tweets + @user.instagrams
  end

  def instagram_post_create
    user = User.find_by(id: session[:user_id])
    if user && user.instagrams
      get_ig_posts(user)

      # Check if db table includes each post;
      # if not, create new InstagramPost
      @all_posts.each do |post|
        params[:instagram_post] = {
          post_id: post[:post_id],
          instagram_id: post[:ig_id],
          image_url: post[:image_url]
        }
        InstagramPost.find_or_create_by(instagram_post_params)
      end
    end
  end

  def tweet_post_create
    user = User.find_by(id: session[:user_id])
    if user && user.tweets
      get_tweet_posts(user)

      @all_posts.each do |post|
        params[:tweet_post] = {
          post_id: post[:post_id],
          posted_at: post[:posted_at],
          text: post[:text],
          media_url: post[:media_url],
          tweet_id: post[:tweet_id]
        }
        TweetPost.find_or_create_by(tweet_post_params)
      end
    end
  end

  private

  def tweet_post_params
    params.require(:tweet_post).permit(:post_id, :posted_at, :text, :media_url, :tweet_id)
  end

  def instagram_post_params
    params.require(:instagram_post).permit(:post_id, :instagram_id, :image_url)
  end

  def get_tweet_posts(user)
    @all_posts = []
    usernames = user.tweets.map &:username
    usernames.each do |username|
      tweet_user_posts = @twitter.client.user_timeline(username, count: 10)
      tweet_user_posts.each do |post|
        @all_posts << { post_id: post.id, posted_at: post.created_at, text: post.text, tweet_id: Tweet.find_by(provider_id: post.user.id).id
        }
        # , media_url: (post.media.first ? post.media.first.media_url : nil)
      end
    end
    return @all_posts
  end

  def get_ig_posts(user)
    # Get an array of all recent post ids associated with
    # all followed instagram users
    @all_posts = []
    user.instagrams.each do |gram|
      ig_user_posts = HTTParty.get(INSTAGRAM_URI + "users/#{gram.provider_id}/media/recent?count=10&access_token=#{session[:access_token]}")
      all_post_ids = ig_user_posts["data"].each do |post|
        @all_posts << { ig_id: gram.id, post_id: post["id"], image_url: post["images"]["low_resolution"]["url"] }
      end
    end
    return @all_posts
  end

end
