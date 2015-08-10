class TwiSubscriptionsController < ApplicationController
  before_action :redirect_if_not_allowed

  def index
    # Guard in case someone tries to access the URL without any search results.
    unless params[:twitter_search].nil?
      client = twitter_api_object
      @results = client.user_search(params[:twitter_search])
    end
  end

  def create
    # Calling find_or_create_subscription and associate_subscription model methods.
    @twitter_id = params[:twitter_id]

    subscription = Subscription.find_or_create_twi_subscription(@twitter_id)

    assign_profile_pic(subscription)

    @user.associate_subscription(subscription)

    client = twitter_api_object
    tweet_array = []
    client.user_timeline(@twitter_id.to_i).each do |tweet|
      tweet_array << tweet
    end

    Post.create_twitter_posts(tweet_array, subscription)

    flash[:notice] = "Subscribed successfully!"

    redirect_to root_path
  end

  def refresh_tweets


    # @user.subscriptions.map do |subscription|
    #   if subscription.twitter_id != nil
    #   end
    # end

    subscriptions = @user.subscriptions.where("twitter_id IS NOT NULL").pluck(:id)

    subscriptions.each do
    client = twitter_api_object
    end
  end

  private

  def assign_profile_pic(subscription)
    subscription.profile_pic = params[:profile_pic]

    subscription.save
  end
end
