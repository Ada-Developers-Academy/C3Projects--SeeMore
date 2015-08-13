class User < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :subscriptions
  has_many :posts, through: :subscriptions

  # Validations
  validates_presence_of :uid, :provider
  validates_uniqueness_of :uid

  # Scopes
  # scope :sorted_order, -> { order(posted_at: :desc) }

  def self.find_or_create_user(auth_hash)
    uid = auth_hash["uid"]
    provider = auth_hash["provider"]

    user = User.where(uid: uid, provider: provider).first_or_initialize
    user.email = auth_hash["info"]["email"]
    user.name = auth_hash["info"]["name"]
    user.image = auth_hash["info"]["image"]

    return user.save ? user : nil
  end

  # Adds the association between a new subscription and the user.
  def associate_subscription(subscription)
    self.subscriptions << subscription
    self.save
  end

  def dissociate_subscription(subscription)
    self.subscriptions.delete(subscription)
  end

  def already_subscribed?(sub_id)
    subscriptions = self.subscriptions

    if subscriptions.find_by(twitter_id: sub_id) || subscriptions.find_by(instagram_id: sub_id)
      return true
    end
  end

  # Returns an ActiveRecord of all instagram subscriptions for that user.
  def instagram_subscriptions
    self.subscriptions.where.not(instagram_id: nil)
  end
end
