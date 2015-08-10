class HomeController < ApplicationController

  def index
    if logged_in?
      client = twitter_api_object
      twitter_ids = @user.twi_subscriptions.pluck(:twitter_id)

      @sub_array_tweets = []

      twitter_ids.each do |twitter_id|
        client.user_timeline(twitter_id.to_i).each do |tweet|
          @sub_array_tweets << tweet
        end
      end

      @sub_array_tweets.sort! { |a,b| b.as_json["created_at"].to_time <=> a.as_json["created_at"].to_time }

      # could transform tweets into our own "post" object...
      # need to combine
    end
  end

  def search
    if params[:website] == "twitter"
      redirect_to twi_subscriptions_path(params: {twitter_search: params[:search]})
    elsif params[:website] == "instagram"
      redirect_to ig_subscriptions_path(params: {instagram_search: params[:search]})
    else
      flash[:error] = "Please search via the search box."
      redirect_to root_path
    end
  end
end
