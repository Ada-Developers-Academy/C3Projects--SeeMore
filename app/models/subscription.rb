class Subscription < ActiveRecord::Base
  # Associations ------------------------
  belongs_to :user
  belongs_to :followee

  # Validations -------------------------
  validates :user_id, :followee_id, presence: true

  # Scopes ------------------------------
  scope :active, -> { where(unsubscribe_date: nil) }

end
