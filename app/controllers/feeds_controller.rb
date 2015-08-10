class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user && @user.instagrams
      @response = []
      @user.instagrams.each do |gram|
        @response << HTTParty.get(INSTAGRAM_URI + "#{gram.provider_id}/media/recent?access_token=#{session[:access_token]}")
      end
    end

    if @user && @user.tweets
      @people = []
      # will eventually combine Instagram and Twitter feeds into one, then sort both together by posted_at time
      # @people << Instagram.find(@user.instagram_ids)
      @people << Tweet.find(@user.tweet_ids)
      @people.flatten!
      # @people.sort_by! { |person| person.username.downcase } # Elsa's comment: why are we sorting @people? @feed will reshuffle everything later

      @feed = []
      @people.each do |person|
        username = person.username
        @feed << @twitter.client.user_timeline(username, count: 10)
        @feed.flatten!
        @feed.sort_by { |tweet| tweet.created_at.strftime("%m/%d/%Y") }
        raise
      end
    end
  end

  def search; end

  def people
    @user = User.find_by(id: session[:user_id])
    if @user
      @people = Instagram.find(@user.instagram_ids) +  Tweet.find(@user.tweet_ids)
    end
  end

end
