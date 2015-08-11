class Subscription < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  has_many :posts

  # Validations
  validate :twitter_xor_instagram_id

  private
    # validates that there is EITHER a twitter OR instagram id
    # can't both be blank or both have values
    def twitter_xor_instagram_id
      if !(twitter_id.blank? ^ instagram_id.blank?)
        errors.add(:ids, "Subscription must have one id")
      end
    end

  # NOTE TO SELF: This does not work as a scope BECAUSE
  # if it finds NOTHING it returns EVERYTHING.
  # This is by design to make scopes chainable.
  # Thx scopes.

  def self.find_twitter_id(id)
    find_by(twitter_id: id)
  end

  def self.find_instagram_id(id)
    find_by(instagram_id: id)
  end

  #So profile pic info not currently being stored.

  def self.find_or_create_twi_subscription(id)
    subscription = find_twitter_id(id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.nil?
      return create(twitter_id: id)
    else
      return subscription
    end
  end

  def self.find_or_create_ig_subscription(id)
    subscription = find_instagram_id(id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.nil?
      return create(instagram_id: id)
    else
      return subscription
    end
  end

  def self.already_subscribed?(user, id)
    user = User.find(user)
    subscriptions = user.subscriptions

    if subscriptions.find_by(twitter_id: id) || subscriptions.find_by(instagram_id: id)
      return true
    end
  end
end
