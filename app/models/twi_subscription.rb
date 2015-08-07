class TwiSubscription < ActiveRecord::Base
  # Validations
  validates :twitter_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

  # NOTE TO SELF: This does not work as a scope BECAUSE
  # if it finds NOTHING it returns EVERYTHING.
  # This is by design to make scopes chainable.
  # Thx scopes.
  def self.find_twitter_id(id)
    find_by(twitter_id: id)
  end

  # Uses twitter_id passed in params from the link_to button from the search results.
  def self.find_or_create_subscription(twitter_id)
    subscription = find_twitter_id(twitter_id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.nil?
      return create(twitter_id: twitter_id)
    else
      return subscription
    end
  end
end
