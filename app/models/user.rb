class User < ActiveRecord::Base
  # Validations ------------------------------------------------------
  validates :uid, :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    uid = auth_hash["uid"]
    provider = auth_hash["provider"]

    user = User.where(uid: uid, provider: provider).first_or_initialize
    user.email = auth_hash["info"]["email"]
    user.name = auth_hash["info"]["name"]

    return user.save ? user : nil
  end
end
