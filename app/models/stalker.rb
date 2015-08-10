class Stalker < ActiveRecord::Base
  has_and_belongs_to_many :prey
  has_many :grams, through: :prey
  has_many :tweets, through: :prey

  #validations
  validates :username, presence: true
  validates :uid, presence: true # TODO: consider customizing the error message
  validates :provider, presence: true
  validate :unique_user_check, on: :create

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

  def unique_user_check
    if Stalker.where(uid: uid, provider: provider).any?
      errors.add(:user_not_unique, "That user already exists!")
    end
  end

  def self.create_params_by_provider(auth_hash)
    case auth_hash["provider"]
    when "developer"
      create_params_using_name(auth_hash)
    when "twitter"
      create_params_using_nickname(auth_hash)
    when "instagram"
      create_params_using_nickname(auth_hash)
    when "vimeo"
      create_params_using_name(auth_hash)
    else
      raise NotImplementedError
    end
  end

  def self.create_params_using_nickname(auth_hash)
    {
      username: auth_hash["info"]["nickname"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end

  def self.create_params_using_name(auth_hash)
    {
      username: auth_hash["info"]["name"],
      uid: auth_hash["uid"],
      provider: auth_hash["provider"]
    }
  end
end
