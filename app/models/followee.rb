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
    if @source == "instagram"
      followee = Followee.where(native_id: user["id"]).find_or_initialize
      followee.source = "instagram"
      followee.handle = user["username"]
      followee.avatar_url = user["profile_picture"]
    elsif @source == "twitter"
      followee = Followee.where(native_id: user.id ).find_or_initialize
      followee.source = "twitter"
      followee.handle = user.screen_name
      followee.avatar_url = user.profile_image_url
    else
      return false # if there's no @source
    end

    return false unless followee.save
    followee
  end
end
