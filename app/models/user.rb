class User < ActiveRecord::Base
  #Validations
  validates :avatar_url,:uid,:provider,  presence: true 
  validates :username, presence: true, uniqueness: true
 
 #Methods

   def self.find_or_create_from_omniauth(auth_hash)

    auth_uid = auth_hash["uid"]
    auth_provider = auth_hash["provider"]

    user = User.where(uid: auth_uid, provider: auth_provider).first_or_initialize
    user.uid =  auth_hash["data"]["id"]
    user.username = auth_hash["data"]["username"]
    user.avatar_url = auth_hash["data"]["profile_picture"]


    return user.save ? user : nil #(could also raise an error here)
  end

end
