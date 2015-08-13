class Subscription < ActiveRecord::Base
  # Associations ------------------------
  belongs_to :user
  belongs_to :followee

  # Validations -------------------------
  validates :user_id, :followee_id, presence: true

  # Scopes ------------------------------
  scope :active, -> { where(unsubscribe_date: nil) }
  scope :active_for_this_followee, -> (followee_id) { where( { followee_id: followee_id, unsubscribe_date: nil}) }

  def self.find_or_create_subscription(current_user, followee)
    subscription = self.find_or_initialize_by(
      user_id: current_user.id,
      followee_id: followee.id
    )

    if !subscription.unsubscribe_date.nil?
      # if user previously subscribed to followee
      subscription = Subscription.create!(user_id: current_user.id, followee_id: followee.id)
    end
    subscription.save

    return subscription
  end

end
