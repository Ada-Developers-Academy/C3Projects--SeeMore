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

  def self.seed_tweets(prey_uid, prey_id, count = SEED_COUNT)
    tweets = TwitterClient.fetch_tweets(prey_uid, { count: count })
    create_many_posts(tweets, prey_id)
  end

  def self.update_tweets(prey_uid, prey_id)
    last_tweet_uid = Prey.last_post_uid(prey_uid)

    if last_tweet_uid.nil?
      tweets = seed_tweets(prey_uid, prey_id)
    else
      tweets = TwitterClient.fetch_tweets(prey_uid, { since_id: last_tweet_uid })
    end

    create_many_posts(tweets, prey_id)
  end

  # GRAMS ---------------------------------------------------------------------

  def self.seed_grams(prey_uid, prey_id, count = SEED_COUNT)
    grams = InstagramClient.seed_grams(prey_uid, count)
    create_many_posts(grams, prey_id)
  end

  def self.update_grams(prey_uid, prey_id)
    last_gram_uid = Prey.last_post_uid(prey_uid)
    grams = InstagramClient.update_grams(prey_uid, last_gram_uid)
    create_many_posts(grams, prey_id)
  end

  private

  def self.create_many_posts(posts, prey_id)
    return if posts.nil?
    posts.each do |post_hash|
      media = post_hash[:media]
      post_hash.delete(:media)

      post = Post.new(post_hash)
      post.prey_id = prey_id
      post.save

      media.each do |medium_url|
        Medium.create(url: medium_url, post_id: post.id)
      end
    end
  end
end
