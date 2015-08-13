class TwiSubscriptionsController < ApplicationController
  before_action :redirect_if_not_allowed
  before_action :twitter_api_object

  def index
    # Guard in case someone tries to access the URL without any search results.
    unless params[:twitter_search].nil?
      @results = @client.user_search(params[:twitter_search])
    end
  end

  def create
    # Calling find_or_create_subscription and associate_subscription model methods.
    @twitter_id = params[:twitter_id]

    subscription = Subscription.find_or_create_twi_subscription(@twitter_id)

    assign_profile_pic(subscription)

    @user.associate_subscription(subscription)

    tweet_array = []

    @client.user_timeline(@twitter_id.to_i).each do |tweet|
      tweet_array << tweet
    end
    subscription_twitter_ids = {subscription.id => tweet_array}
    Post.create_twitter_posts(subscription_twitter_ids)
    flash[:notice] = "The Beast eats tweets for breakfast! Yum!"

    redirect_to root_path
  end

  def refresh_twi
    sub_twit_array = @user.subscriptions.where("twitter_id IS NOT NULL").pluck(:id, :twitter_id)

    sub_twit_array.each do |sub_id, twit_id|
      @tweet_array = []
      @client.user_timeline(twit_id.to_i).each do |twit_id|
        @tweet_array << twit_id
      end

      subscription_twitter_ids = {sub_id => @tweet_array}

      Post.create_twitter_posts(subscription_twitter_ids)
    end

    redirect_to root_path
  end

  private

    def assign_profile_pic(subscription)
      subscription.profile_pic = params[:profile_pic]

      subscription.save
    end

    def twitter_api_object
      @client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV["TWITTER_CLIENT_ID"]
        config.consumer_secret     = ENV["TWITTER_CLIENT_SECRET"]
        config.access_token        = ENV["TWITTER_ACCESS_TOKEN"]
        config.access_token_secret = ENV["TWITTER_ACCESS_SECRET"]
      end
    end
end
