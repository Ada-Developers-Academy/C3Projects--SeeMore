class Stalker < ActiveRecord::Base
  #validations
  validates :username, presence: true
  validates :uid, presence: true # TODO: consider customizing the error message
  validates :provider, presence: true

  def self.find_or_create_from_auth_hash(auth_hash)
    create_params = create_params_by_provider(auth_hash)

    Stalker.find_or_create(create_params)
  end

  def self.find_or_create(create_params)
    Stalker.create_with(username: create_params[:username])
      .find_or_create_by(
        uid: create_params[:uid],
        provider: create_params[:provider]
      )
  end

  private
  def self.create_params_by_provider(auth_hash)
    case auth_hash["provider"]
    when "developer"
      #
    when "twitter"
      twitter_create_params(auth_hash)
    when "instagram"
      # instagram_create_params
    when "vimeo"
      vimeo_create_params(auth_hash)
    end
  end

  def self.twitter_create_params(auth_hash)

    {
      username: auth_hash["info"]["nickname"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end

  def self.vimeo_create_params(auth_hash)
    {
      username: auth_hash["info"]["name"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end


  def self.find_or_create_from_instagram(auth_hash)
    create_params = instagram_create_params(auth_hash)
    Stalker.create_with(username: create_params[:username])
      .find_or_create_by(
        uid: create_params[:uid],
        provider: create_params[:provider]
      )
  end

  def self.instagram_create_params(auth_hash)
    {
      username: auth_hash["info"]["nickname"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end

end
