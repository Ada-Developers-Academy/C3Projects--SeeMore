class Stalker < ActiveRecord::Base
  #validations
  validates :username, presence: true
  validates :uid, presence: true
  validates :provider, presence: true

  def self.find_or_create_from_omniauth(auth_hash)
    uid = auth_hash["uid"]
    provider = auth_hash["provider"]

    stalker = Stalker.where(uid: uid, provider: provider).first_or_initialize
    stalker.username = auth_hash["info"]["name"]

    return stalker.save ? stalker : nil
  end

  def self.find_or_create_from_twitter(auth_hash)
    create_params = twitter_create_params(auth_hash)
    Stalker.create_with(username: create_params[:username])
      .find_or_create_by(
        uid: create_params[:uid],
        provider: create_params[:provider]
      )
  end

  def self.twitter_create_params(auth_hash)
    {
      username: auth_hash["info"]["nickname"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end
end
