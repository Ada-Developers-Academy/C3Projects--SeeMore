class Gram < ActiveRecord::Base
  #Associations
  belongs_to :instagram_user

# Scopes -----------------------------------------------------------------------
  scope :latest_posts, ->(limit) { order('created_at DESC').limit(limit) }
end
