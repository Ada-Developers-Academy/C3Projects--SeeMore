class TwitterClient
  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  def user_search(user, count=3)
    client.user_search(user, options = {count: count})
  end

  def user_timeline(user)
    # followee = Followee.find_by(handle: user)
    # last_tweet_id = Posts.find_by(followee_id: followee.id).last
    # client.user_timeline(user, options = {since_id: last_tweet_id} ) # - use this one in real setting
    client.user_timeline(user)
    # default returns the 20 most recent tweets of the user
    # set the since_id parameter to the greatest ID of all the Tweets your application has already processed
    # can search by user_id or screen_name
  end
end
