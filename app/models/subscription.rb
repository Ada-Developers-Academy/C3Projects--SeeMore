class Subscription < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  has_many :posts

  # Validations
  # would be good to write a validation that it has either a twitter_id OR an instagram_id

  # NOTE TO SELF: This does not work as a scope BECAUSE
  # if it finds NOTHING it returns EVERYTHING.
  # This is by design to make scopes chainable.
  # Thx scopes.

  # REFACTOR for shared model
  # def self.find_twitter_id(id)
  #   find_by(twitter_id: id)
  # end
  #
  # # Uses twitter_id passed in params from the link_to button from the search results.
  # def self.find_or_create_subscription(id)
  #   subscription = find_twitter_id(twitter_id)
  #
  #   # If there's not a subscription, will create one or return the subscription found.
  #   if subscription.nil?
  #     return create(twitter_id: twitter_id)
  #   else
  #     return subscription
  #   end
  # # end
  # def self.find_instagram_id(id)
  #   find_by(instagram_id: id)
  # end
  #
  # def self.find_or_create_subscription(instagram_id)
  #   subscription = find_instagram_id(instagram_id)
  #
  #   if subscription.nil?
  #     return create(instagram_id: instagram_id)
  #   else
  #     return subscription
  #   end
  # end
  #

end
