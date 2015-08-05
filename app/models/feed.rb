class Feed < ActiveRecord::Base
  # Associations--------------------------------------------
  has_and_belongs_to_many :authetnicated_users
  has_many :posts
end
