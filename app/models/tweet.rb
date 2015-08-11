class Tweet < ActiveRecord::Base
  # Associations
  belongs_to :tw_users

  # Validations
  validates :tw_created_at, :tw_user_id_str, presence: true
  validates :tw_id_str, presence: true, uniqueness: true

  # Methods
  def self.update_timeline(user)
    followees = user.tw_users

    followees.each do |followee|
      # the twitter id of the followee as an integer
      id = followee.tw_user_id_str.to_i
      # the twitter id of the last saved tweet by that followee
      last_id = Tweet.find_by(tw_user_id_str: id).last.tw_id_str.to_i
      # fetches their recent tweets
      recent_tweets = @twit_init.client.user_timeline(id, since_id: last_id)

      tweet_factory
    end
  end

  private

  def tweet_factory
    recent_tweets.each do |tweet|
      our_tweet = Tweet.new
      our_tweet.tw_user_id_str = tweet.user.id
      our_tweet.tw_id_str = tweet.id_str
      our_tweet.tw_text = tweet.text
      our_tweet.tw_created_at = tweet.created_at
      our_tweet.tw_retweet_count = tweet.retweet_count
      our_tweet.tw_favorite_count = tweet.favorite_count
      # save the tweets in the db
      our_tweet.save
    end
  end
end
