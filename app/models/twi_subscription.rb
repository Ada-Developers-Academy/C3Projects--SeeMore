class TwiSubscription < ActiveRecord::Base
  # Validations
  validates :twitter_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

end
