class HomeController < ApplicationController

  def index

    client = twitter_api_object
    twitter_ids = User.find(session[:user_id]).twi_subscriptions.pluck(:twitter_id)

    @sub_array = []

    twitter_ids.each do |twitter_id|
      client.user_timeline(twitter_id.to_i).each do |tweet|
        @sub_array << tweet
      end
    end


    @sub_array.sort! { |a,b| b.as_json["created_at"].to_time <=> a.as_json["created_at"].to_time }

    # sub_array.order by time
  end

end
