class TwitterApi
  attr_reader :client

  # the number of posts to get
  # the first time you update your feed after following someone
  FIRST_POSTS = 5

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

  def embed_html_without_js(tweet_id)
    client.oembed(tweet_id, { omit_script: true })[:html]
  end

  def get_posts(id, last_post_id)
    posts = client.user_timeline(id, timeline_options(last_post_id))
  end

  def timeline_options(last_post_id)
    last_post_id ? { since_id: last_post_id.to_i } : { count: FIRST_POSTS }
  end
end
