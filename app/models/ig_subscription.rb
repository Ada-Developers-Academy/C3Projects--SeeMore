class IgSubscription < ActiveRecord::Base
  # Validations
  validates :instagram_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

  # Scopes

  # Class Methods

  def self.find_instagram_id(id)
    find_by(instagram_id: id)
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
