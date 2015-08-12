require 'twitter_client'
require 'instagram_client'

class Post < ActiveRecord::Base
  SEED_COUNT = 5

  belongs_to :prey
  has_many :media

  validates :uid, :post_time, :prey_id, :url, :provider, presence: true
  # tweet and gram uids should never be the same. they are formatted differently
  validates :uid, uniqueness: true

  # TWEETS --------------------------------------------------------------------

  def self.seed_tweets(prey_uid, count = SEED_COUNT, prey_id)
    tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
    create_many_tweets(tweets, prey_id)
  end

  def self.update_tweets(prey_uid, prey_id)
    last_tweet_uid = Prey.last_post_uid(prey_uid)
    tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
    create_many_tweets(tweets, prey_id)
  end

  # GRAMS ---------------------------------------------------------------------

  def self.seed_grams(prey_uid, count = SEED_COUNT)
    grams = InstagramClient.seed_grams(prey_uid, count)
    create_many_grams(grams)
  end

  def self.update_grams(prey_uid, prey_id)
    last_gram_uid = Prey.last_post_uid(prey_uid)
    grams = InstagramClient.update_grams(prey_uid, last_gram_uid)
    create_many_grams(grams, prey_id)
  end

  private
  # TWEETS --------------------------------------------------------------------

  def self.create_many_tweets(tweets, prey_id)
    tweets.each do |tweet|
      media = tweet[:media]
      tweet.delete(:media)

      post = Post.new(tweet)
      post.prey_id = prey_id
      post.save

      media.each do |medium|
        Medium.create(url: medium, post_id: post.id)
      end
    end
  end

  # GRAMS ---------------------------------------------------------------------

  def self.create_many_grams(grams)
    grams.each do |gram|
      post = Post.create(create_gram_params_from_api(gram))
      Medium.create(url: gram["images"]["standard_resolution"]["url"], post_id: post.id)
    end
  end
end
