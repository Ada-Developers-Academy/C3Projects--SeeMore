class TwitterApi
  attr_reader :client

  # the number of posts to get
  # the first time you update your feed after following someone
  FIRST_POSTS = 1

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_SECRET']
    end
  end

  # these three stay in Api class
  def user_search(user, count=3)
    client.user_search(user, options = {count: count})
  end

  def embed_html_without_js(tweet_id)
    client.oembed(tweet_id, { omit_script: true })[:html]
  end

  def get_posts(id, last_post_id)
    client.user_timeline(id, timeline_options(last_post_id))
  end

  private
  # put in TwitterMapper ?
  ### we're leaving this here because it is called by #get_posts above
  ### and we don't want to create a dependency in this class on the TwitterMapper class
  def timeline_options(last_post_id)
    last_post_id ? { since_id: last_post_id.to_i } : { count: FIRST_POSTS }
  end
end
