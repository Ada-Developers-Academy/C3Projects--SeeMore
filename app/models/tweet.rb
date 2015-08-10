class Tweet < ActiveRecord::Base
  belongs_to :prey
  has_many :tweet_media

end
