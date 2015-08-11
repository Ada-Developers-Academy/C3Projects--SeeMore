class TweetPost < ActiveRecord::Base
  # Associations ----------------------------------------------
  belongs_to :tweet
  has_many :users, through: :tweet

  # Validations ----------------------------------------------
  validates :post_id, :posted_at, :tweet_id, presence: true
  validates :post_id, uniqueness: true

  def self.find_or_create_from_twitter_api(twitter_api)
    post_id = twitter_api["id"]

    tweet_post = TweetPost.where(post_id: post_id)
    tweet_post.posted_at = twitter_api["created_at"]
    tweet_post.text = twitter_api["text"]
    tweet_post.media_url = ["entities"]["media"]["media_url"]

    tweet_person = Tweet.find_by(provider_id: twitter_api["user"]["id"])
    tweet_post.tweet_id = tweet_person.id

    return tweet_post.save ? tweet_post : nil
  end
end
