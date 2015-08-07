class Followee < ActiveRecord::Base
# ASSOCIATIONS ----------------------------------
  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions

# VALIDATIONS -----------------------------------
  validates :handle, presence: true
  validates :source, presence: true
  validates :native_id, presence: true

# SCOPES ----------------------------------------
  
  def self.find_or_create_by(native_id)
  end
end
