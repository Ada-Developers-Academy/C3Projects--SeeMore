class Feed < ActiveRecord::Base
  # Associations--------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts

  # Validations---------------------------------------------
  validates :name, :platform, :platform_feed_id, presence: true
end
