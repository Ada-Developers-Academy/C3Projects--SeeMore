class Subscription < ActiveRecord::Base
  # Associations ------------------------
  belongs_to :user
  belongs_to :followee

  # Validations -------------------------
  validates :user_id, :followee_id, presence: true

  def self.make_subscription(user_id, followee)
    subscription = Subscription.new
    # binding.pry
    subscription = self.create(user_id: user_id, followee_id: followee.id)

    subscription.save ? subscription : false
  end
end
