class Subscription < ActiveRecord::Base
  # Associations ------------------------
  belongs_to :user
  belongs_to :followee

  # Validations -------------------------
  validates :user_id, :followee_id, presence: true

  def self.make_subscription(current_user, followee)
    subscription = Subscription.new
    subscription = self.create(user_id: current_user.id, followee_id: followee.id)

    subscription.save ? subscription : false
  end
end
