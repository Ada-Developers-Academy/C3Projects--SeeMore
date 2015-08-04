class User < ActiveRecord::Base

  # Validations
  validates_presence_of :name, :uid, :provider
  validates_uniqueness_of :name, :uid


  def self.find_or_create_user(auth_hash)
    uid = auth_hash["uid"]
    provider = auth_hash["provider"]

    user = User.where(uid: uid, provider: provider).first_or_initialize
    user.email = auth_hash["info"]["email"]
    user.name = auth_hash["info"]["name"]
    user.image = auth_hash["info"]["image"]

    return user.save ? user : nil
  end
end
