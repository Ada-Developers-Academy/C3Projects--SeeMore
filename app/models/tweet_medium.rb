class TweetMedium < ActiveRecord::Base
  belongs_to :tweet

  validates :tweet_id, :url, presence: true
end
