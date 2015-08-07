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
  
  # pass in a user search result object
  def self.find_or_create_by(user)
    if # search path was instagram
      followee = Followee.where(native_id: user["id"]).find_or_initialize
      followee.source = "instagram"
      followee.handle = user["username"]
      followee.avatar_url = user["profile_picture"]
    elsif # search path was twitter
      followee = Followee.where(native_id: user.id ).find_or_initialize
      followee.source = "twitter"
      followee.handle = user.screen_name
      followee.avatar_url = user.profile_image_url
    end
    followee.save
    # check for if save fails
  end
end
