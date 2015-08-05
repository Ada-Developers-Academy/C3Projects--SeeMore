class Stalker < ActiveRecord::Base
  #validations
  validates :username, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

    def self.find_or_create_from_omniauth(auth_hash)
      uid = auth_hash["uid"]
      provider = auth_hash["provider"]

      user = User.where(uid: uid, provider: provider).first_or_initialize
      user.username = auth_hash["info"]["name"]

      return user.save ? user: nil
    end
end
