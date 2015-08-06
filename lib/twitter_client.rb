class TwitterClient
  def self.client
    Twitter::REST::Client.new do |config|
      config.consumer_key = ENV["TWITTER_API_KEY"]
      config.consumer_secret = ENV["TWITTER_API_SECRET"]
      config.access_token = ENV["TWITTER_ACCESS_TOKEN"]
      config.access_token_secret = ENV["TWITTER_TOKEN_SECRET"]
    end
  end

  def self.user_search(search_term)
   client.user_search(search_term)
  end
end
