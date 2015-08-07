class TwiSubscription < ActiveRecord::Base
  # Validations
  validates :twitter_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

  #Scopes
  scope :find_twitter_id, -> (twitter_id) { find_by(twitter_id: twitter_id) }

  def self.find_or_create_subscription(twitter_id)
    subscription = find_twitter_id(twitter_id)

    if subscription.empty?
      return create(twitter_id: twitter_id)
    else
      return subscription
    end
  end
end
