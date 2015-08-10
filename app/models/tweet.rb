require 'twitter_client'

class Tweet < ActiveRecord::Base
  belongs_to :prey
  has_many :tweet_media

  validates :uid, :post_time, :prey_id, :url, presence: true

  def self.seed_tweets(prey_uid, count = 5)
    tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
    create_many_from_api(tweets)
  end

  def self.update_tweets(prey_uid)
    last_tweet_uid = tweets.order(:uid).last.uid
    tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
    create_many_from_api(tweets)
  end

  def self.create_many_from_api(tweets)
    tweets.each do |tweet|
      tweet_id = Tweet.create(create_params_from_api(tweet)).id
      tweet.media.each do |medium|
        TweetMedium.create(url: medium.media_url_https.to_s, tweet_id: tweet_id)
      end
    end
  end

  private

  def self.create_params_from_api(tweet)
    { uid: tweet.id,
      body:  tweet.text,
      post_time: tweet.created_at,
      prey_id: Prey.find_by(uid: tweet.user.id).id,
      url: tweet.url
    }
  end
end
