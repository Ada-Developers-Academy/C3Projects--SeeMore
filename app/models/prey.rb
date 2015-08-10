require 'twitter_client'

class Prey < ActiveRecord::Base
  has_and_belongs_to_many :stalkers
  has_many :posts

  validates :uid, :provider, presence: true
  after_create :seed_tweets

  def update_tweets
    Post.update_tweets(uid)
  end

  def self.create_from_username(username)
    prey = TwitterClient.find_user(username)
    Prey.create(create_params_from_api(prey))
  end

  private

  def seed_tweets
    Post.seed_tweets(self.uid)
  end

  def self.create_params_from_api(prey)
    { uid: prey.id,
      name: prey.name,
      username: prey.screen_name,
      provider: "twitter",
      photo_url: prey.profile_image_url_https.to_s,
      profile_url: prey.url.to_s
    }
  end

end
