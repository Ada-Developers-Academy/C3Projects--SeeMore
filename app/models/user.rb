class User < ActiveRecord::Base
  # Associations
  has_many :tweets
  #Validations
  validates :avatar_url,:uid,:provider,  presence: true 
  validates :username, presence: true, uniqueness: true
 
 #Methods

   def self.find_or_create_from_omniauth(auth_hash)

    auth_uid = auth_hash["uid"]
    auth_provider = auth_hash["provider"]
    user = User.where(uid: auth_uid, provider: auth_provider).first_or_initialize
    if :provider == "instagram"
      user.uid =  auth_hash["data"]["id"]
      user.username = auth_hash["data"]["username"]
      user.avatar_url = auth_hash["data"]["profile_picture"]
    else
      user.uid =  auth_hash["info"]["uid"]
      user.username = auth_hash["info"]["username"]
    end

  # TODO: raise an error here instead of `nil`
    return user.save ? user : nil 
  end

end
