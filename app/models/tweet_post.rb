class TweetPost < ActiveRecord::Base
  # Associations ----------------------------------------------
  belongs_to :tweet
  has_many :users, through: :tweet

  # Validations ----------------------------------------------
  validates :post_id, :posted_at, :tweet_id, presence: true
  validates :post_id, uniqueness: true

end
