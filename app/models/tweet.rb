class Tweet < ActiveRecord::Base
  # Associations
  belongs_to :tw_users

  # Validations
  validates :tw_user_id_str, :tw_created_at, :tw_text, :user_id, presence: true
  validates :tw_id_str, presence: true, uniqueness: true

  # def self.follow(tw_user)
  #   # this should just create a join table association between the user
  #   # and a tweet
  #   tweets = @twit_init.client.user_timeline(tw_user).take(5)
  #   # TODO: This number five is arbitrary. Decide how many tweets to take later.
  #   # for each tweet make the foreign key user_id = the sessions user_id
  #   tweets.each do |tweet|
  #     our_tweet = Tweet.new
  #     our_tweet.tw_user_id_str = tweet.user.id
  #     our_tweet.tw_user_name_str = tweet.user.name
  #     our_tweet.tw_user_image_url = tweet.user.profile_image_url
  #     our_tweet.tw_user_screen_name = tweet.user.screen_name
  #     our_tweet.tw_id_str = tweet.id_str
  #     our_tweet.tw_text = tweet.text
  #     our_tweet.tw_created_at = tweet.created_at
  #     our_tweet.tw_retweet_count = tweet.retweet_count
  #     our_tweet.tw_favorite_count = tweet.favorite_count
  #     # save the tweets in the db
  #     our_tweet.save
  #   end
  # end
end
