class Followee < ActiveRecord::Base
# ASSOCIATIONS ----------------------------------
  has_many :posts
  has_many :subscriptions
  has_many :users, through: :subscriptions

# VALIDATIONS -----------------------------------
  validates :handle, :source, :native_id, presence: true

# SCOPES ----------------------------------------

  def self.find_or_create_by(followee_hash)
    followee = self.find_or_initialize_by(native_id: followee_hash[:id])
    followee.source = followee_hash[:source]
    followee.handle = followee_hash[:username]
    followee.avatar_url = followee_hash[:picture] || followee_hash[:avatar_url]

    followee.save ? followee : false
  end

  def self.update_last_post_id!(posts, followee, source)
    new_last_post_id = (source == ApplicationController::TWITTER) ? posts.first.id : posts.first["id"]
    followee.update!(last_post_id: new_last_post_id)
  end
end
