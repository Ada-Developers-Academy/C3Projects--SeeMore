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
  
  # plug this into a "add_subscription" action thru a button by each user
  # the "user" parameter is each twitter or instagram user in the search results

  def self.find_or_create_by(user)
    if params[:source] == "instagram"
      followee = self.find_or_initialize_by(native_id: user["id"])
      followee.source = "instagram"
      followee.handle = user["username"]
      followee.avatar_url = user["profile_picture"]
    elsif params[:source] == "twitter"
      followee = self.find_or_initialize_by(native_id: user.id )
      followee.source = "twitter"
      followee.handle = user.screen_name
      followee.avatar_url = user.profile_image_url
    else
      return false # if there's no @source
    end

    followee.save ? followee : false
  end
end
