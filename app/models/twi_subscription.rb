class TwiSubscription < ActiveRecord::Base
  # Validations
  validates :twitter_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

  #Scopes
  scope :find_twitter_id, -> (twitter_id) { find_by(twitter_id: twitter_id) }

  # Uses twitter_id passed in params from the link_to button from the search results.
  def self.find_or_create_subscription(twitter_id)
    subscription = find_twitter_id(twitter_id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.empty? # not nil!
      return create(twitter_id: twitter_id)
    else
      return subscription
    end
  end
end
