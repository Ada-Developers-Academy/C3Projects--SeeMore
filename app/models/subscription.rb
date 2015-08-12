class Subscription < ActiveRecord::Base
  # Associations ------------------------
  belongs_to :user
  belongs_to :followee

  # Validations -------------------------
  validates :user_id, :followee_id, presence: true

  # Scopes ------------------------------
  scope :active, -> { where(unsubscribe_date: nil) }

  def self.find_or_create_subscription(current_user, followee)
    # subscription = Subscription.new
    subscription = self.find_or_initialize_by(user_id: current_user.id, followee_id: followee.id)

    subscription.save ? subscription : false
  end

end
