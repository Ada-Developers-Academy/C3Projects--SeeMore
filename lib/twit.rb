class Twit
  CLIENT = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
    config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
    config.access_token = ENV['TWITTER_ACCESS_TOKEN']
    config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
  end

  def self.user_search(search_term)
    CLIENT.user_search(search_term)
  end

  def self.user_timeline(search_term)
    CLIENT.user_timeline(search_term)
  end
end
