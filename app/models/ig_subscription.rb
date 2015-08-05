class IgSubscription < ActiveRecord::Base
  # Validations
  validates :instagram_id, presence: true, uniqueness: { case_sensitive: false }

  # Associations
  has_and_belongs_to_many :users

  # Scopes
end
