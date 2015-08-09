class TweetPost < ActiveRecord::Base
  # Associations ----------------------------------------------
  belongs_to :tweet

  # Validations ----------------------------------------------
  validates :post_id, :posted_at presence: true
  validates :post_id uniqueness: true

  def self.find_or_create_from_twitter_api(response)
    post_id = response["id"]

    tweet_post = TweetPost.where(post_id: post_id)
    tweet_post.posted_at = response["created_at"]
    tweet_post.text = response["text"]
    tweet_post.media_url = ["entities"]["media"]["media_url"]

    tweet_person = Tweet.find_by(provider_id: response["user"]["id"])
    tweet_post.tweet_id = tweet_person.id

    return tweet_post.save ? tweet_post : nil
  end
end
