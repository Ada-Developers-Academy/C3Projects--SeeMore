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


  # Not sure if this id == @twitter_id is 100% failsafe
  def self.find_id(id)
    if id == @twitter_id
      find_by(twitter_id: id)
    else
      find_by(instagram_id: id)
    end
  end

  #
  # Uses twitter_id passed in params from the link_to button from the search results.

  # Ideally would like to be able to pass in the profile_pic info as a parameter here as well. Not currently happening
  #So profile pic info not currently being stored.
  def self.find_or_create_subscription(id)
    subscription = find_id(id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.nil?
      unless :instagram_id == nil
        return create(instagram_id: id)
      else
        return create(twitter_id: id)
      end
    else
      return subscription
    end
  end
end
