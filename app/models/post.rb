require 'twitter_client'
require 'instagram_client'

class Post < ActiveRecord::Base
  belongs_to :prey
  has_many :media

  validates :uid, :post_time, :prey_id, :url, :provider, presence: true
  # tweet and gram uids should never be the same. they are formatted differently
  validates :uid, uniqueness: true

  # TWEETS --------------------------------------------------------------------

  def self.seed_tweets(prey_uid, count = 5)
    tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
    create_many_tweets_from_api(tweets)
  end

  def self.update_tweets(prey)
    last_tweet_uid = prey.posts.maximum(:uid)
    tweets = TwitterClient.fetch_tweets(prey.uid, { since_id: last_tweet_uid })
    create_many_tweets_from_api(tweets)
  end

  # GRAMS ---------------------------------------------------------------------

  def self.seed_grams(prey_uid)
    grams = InstagramClient.seed_grams(prey_uid)
    create_many_grams_from_api(grams)
  end

  def self.update_grams(prey_uid)
    last_gram_uid = Prey.find_by(uid: prey_uid).posts.last.uid
    grams = InstagramClient.update_grams(prey_uid, last_gram_uid)
    create_many_grams_from_api(grams)
  end

  private
  # TWEETS --------------------------------------------------------------------

  def self.create_many_tweets_from_api(tweets)
    tweets.each do |tweet|
      post_id = Post.create(create_tweet_params_from_api(tweet)).id
      tweet.media.each do |medium|
        Medium.create(url: medium.media_url_https.to_s, post_id: post_id)
      end
    end
  end

  def self.create_tweet_params_from_api(tweet)
    { uid: tweet.id,
      body:  tweet.text,
      post_time: tweet.created_at,
      prey_id: Prey.find_by(uid: tweet.user.id).id,
      url: tweet.url,
      provider: "twitter"
    }
  end

  # GRAMS ---------------------------------------------------------------------

  def self.create_many_grams_from_api(grams)
    # Instagram API returns most recent post first, but we want it in reverse
    grams.reverse!
    grams.each do |gram|
      post = Post.create(create_gram_params_from_api(gram))
      Medium.create(url: gram["images"]["standard_resolution"]["url"], post_id: post.id)
    end
  end

  def self.create_gram_params_from_api(gram)
    { uid: gram["id"],
      body: gram["caption"]["text"],
      post_time: convert_unix_to_datetime(gram["created_time"]),
      prey_id: Prey.find_by(uid: gram["user"]["id"]).id,
      url: gram["link"],
      provider: "instagram"
    }
  end

  def self.convert_unix_to_datetime(time)
    Time.at(time.to_i).to_datetime
  end
end
