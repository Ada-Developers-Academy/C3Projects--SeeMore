require 'twitter_client'

class Post < ActiveRecord::Base
  belongs_to :prey
  has_many :media

  validates :uid, :post_time, :prey_id, :url, :provider, presence: true

  def self.seed_tweets(prey_uid, count = 5)
    tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
    create_many_tweets_from_api(tweets)
  end

  def self.seed_grams(prey_uid, count = 5)
    # TODO: fill in :)
  end

  def self.update_tweets(prey_uid)
    last_tweet_uid = Prey.find_by(uid: prey_uid).posts.last.uid
    tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
    create_many_tweets_from_api(tweets)
  end

  def self.update_grams(prey_uid)
    # TODO: fill in :)
  end

  private

  def self.create_many_tweets_from_api(tweets)
    tweets.each do |tweet|
      post_id = Post.create(tweet_create_params_from_api(tweet)).id
      tweet.media.each do |medium|
        Medium.create(url: medium.media_url_https.to_s, post_id: post_id)
      end
    end
  end

  def self.tweet_create_params_from_api(tweet)
    { uid: tweet.id,
      body:  tweet.text,
      post_time: tweet.created_at,
      prey_id: Prey.find_by(uid: tweet.user.id).id,
      url: tweet.url,
      provider: "twitter"
    }
  end

end
