class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user && @user.instagrams
      @response = []
      @user.instagrams.each do |gram|
        @response << HTTParty.get(INSTAGRAM_URI + "#{gram.provider_id}/media/recent?access_token=#{session[:access_token]}")
      end
    end



    # to get @user's feed
    # first, find all @user's people from Tweet table
    # for each person, retrieve all TweetPosts with that tweet_id fk, push them into a collection
      # (if none yet, aka first time following that person, then just fetch/create from API)
      # else, from all people's tweet_posts, find max posted_at time (most recent time)
      # pass that time also into Twitter API call to fetch tweets made since, save those to db
      # display tweets from db

    # from those people, give Twitter API their username to retrieve their tweets
    # for each person, call self.find_or_create_from_twitter_api on the API response to save all their tweets to the db

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
      end
    end
  end

  # TweetPost model
  # ---------------
  # post_id:integer     ([id])
  # posted_at:datetime  ([created_at])
  # text:text           ([text])
  # media_url:string    ([entities][media][media_url])
  # tweet_id:integer    (Tweet model FK)


  def search; end

  def people
    @user = User.find_by(id: session[:user_id])
    if @user
      @people = Instagram.find(@user.instagram_ids) +  Tweet.find(@user.tweet_ids)
    end
  end

end
