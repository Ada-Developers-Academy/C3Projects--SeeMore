require 'twitter_client'

class Prey < ActiveRecord::Base
  has_and_belongs_to_many :stalkers
  has_many :posts

  validates :uid, :provider, presence: true
  after_create :seed_posts

  scope :last_post_uid, -> (prey_uid) { Prey.find_by(uid: prey_uid).posts.maximum(:uid) }

  def update_posts
    Post.update_tweets(self) if tweeter?
    Post.update_grams(uid) if grammer?
  end

  def tweeter?
    provider == "twitter"
  end

  def grammer?
    provider == "instagram"
  end

  private

  def seed_posts
    Post.seed_tweets(self.uid) if self.tweeter?
    Post.seed_grams(self.uid) if self.grammer?
  end
end
