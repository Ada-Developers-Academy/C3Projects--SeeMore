class Tweet < ActiveRecord::Base
  # Associations
  belongs_to :tw_users

  # Validations
  validates :tw_created_at, :tw_user_id_str, :tw_user_id, presence: true
  validates :tw_id_str, presence: true, uniqueness: true

  # Scope
  scope :chron_tweets, -> { order("tw_created_at DESC") }

  # Methods
  def self.update_timeline(user)
    followees = user.tw_users
    @twit_init = TwitInit.new
    followees.each do |followee|
      # the twitter id of the followee as an integer
      id = followee.tw_user_id_str.to_i

      if followee.tweets.count == 0
        # get the last 5 tweets and save them to the database for a new followee
        recent_tweets = @twit_init.client.user_timeline(id).take(5)
      else
        # the twitter id of the last saved tweet by that followee
        last_id = Tweet.where(tw_user_id_str: id).last.tw_id_str.to_i
        # fetches their recent tweets
        recent_tweets = @twit_init.client.user_timeline(id, since_id: last_id)
      end

      self.tweet_factory(recent_tweets, followee.id)
    end
  end

  def self.tweet_factory(recent_tweets, followee_id)
    recent_tweets.each do |tweet|
      our_tweet = Tweet.new
      our_tweet.tw_user_id_str = tweet.user.id
      our_tweet.tw_id_str = tweet.id.to_s
      our_tweet.tw_text = tweet.text
      our_tweet.tw_created_at = tweet.created_at
      our_tweet.tw_retweet_count = tweet.retweet_count
      our_tweet.tw_favorite_count = tweet.favorite_count
      our_tweet.tw_user_id = followee_id
      # save the tweets in the db
      our_tweet.save
    end
  end
end
