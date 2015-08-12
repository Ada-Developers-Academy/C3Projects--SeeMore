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

  # stay in model
  def self.find_or_create_by(followee_hash)
    followee = self.find_or_initialize_by(native_id: followee_hash[:id])
    followee.source = followee_hash[:source]
    followee.handle = followee_hash[:username]
    followee.avatar_url = followee_hash[:picture] || followee_hash[:avatar_url]

    followee.save ? followee : false
  end

  # this goes in api helper
  def self.user_search(query, count, source)
    case source
    when ApplicationController::INSTAGRAM
      InstagramApi.new.user_search(query, count)
    when ApplicationController::TWITTER
      TwitterApi.new.user_search(query, count)
    end
  end

  # stay in model
  def self.update_last_post_id!(posts, followee, source)
    new_last_post_id = assign_last_post_id(posts, followee, source)
    followee.update!(last_post_id: new_last_post_id)
  end

  # put this into the method above
  # remove followee, not used
  def self.assign_last_post_id(posts, followee, source)
    source == ApplicationController::TWITTER ? posts.first.id : posts.first["id"]
  end
end
