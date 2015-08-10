class TwitterClient
  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV["TWITTER_API_KEY"]
    config.consumer_secret = ENV["TWITTER_API_SECRET"]
    config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
    config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
  end

  def self.user_search(search_term)
    CLIENT.user_search(search_term)
  end

  def self.fetch_tweets(user_uid, options = {})
      CLIENT.user_timeline(user_uid.to_i, options)
    # TODO: client.user_timeline(user, { since_id: ?, count: ?, include_rts: true } )
  end
end
