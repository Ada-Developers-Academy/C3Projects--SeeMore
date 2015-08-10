class Subscription < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  has_many :posts

  # Validations
  validate :twitter_xor_instagram_id
  # would be good to write a validation that it has either a twitter_id OR an instagram_id

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

  # REFACTOR for shared model
  def self.find_id(id)
    if params[:twitter_search]
      find_by(twitter_id: id)
    else
      find_by(instagram_id: id)
    end
  end

  #
  # Uses twitter_id passed in params from the link_to button from the search results.
  def self.find_or_create_subscription(id)
    subscription = find_id(id)

    # If there's not a subscription, will create one or return the subscription found.
    if subscription.nil?
      return create(twitter_id: twitter_id)
    else
      return subscription
    end
  end


  def self.find_or_create_subscription(instagram_id)
    subscription = find_instagram_id(instagram_id)

    if subscription.nil?
      return create(instagram_id: instagram_id)
    else
      return subscription
    end
  end


end
