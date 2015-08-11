class User < ActiveRecord::Base
  # Associations

  has_many :tweets
  has_and_belongs_to_many :instagram_users
  has_many :grams, through: :instagram_users
  #Validations

  has_and_belongs_to_many :tw_users
  has_many :tweets, through: :tw_users

  # Validations

  validates :avatar_url,:uid,:provider,  presence: true
  validates :username, presence: true, uniqueness: true

  # Methods
  # def self.find_or_create_from_instagram(response)
  #   auth_uid = response['id']
  #   auth_provider = 'instagram'
  #
  #   user = User.where(uid: auth_uid, provider: auth_provider).first_or_initialize
  #   user.username = response['data']['username']
  #   user.avatar_url = response['data']['profile_picture']
  #
  #   return user.save ? user : nil
  # end


  def self.find_or_create_from_omniauth(auth_hash)
    instagram = auth_hash["user"]
    auth_uid = instagram.nil? ? "nil" : instagram["id"]
    auth_provider = instagram.nil? ? "developer" : "instagram"

    user = User.where(uid: auth_uid, provider: auth_provider).first_or_initialize
    user.uid      = instagram.nil?   ? "nil" : instagram["id"]
    user.provider = instagram.nil?   ? "developer" : "instagram"
    user.username = instagram.nil?   ? auth_hash["info"]["name"] : instagram["username"]
    user.avatar_url = instagram.nil? ? "nil" : instagram["profile_picture"]

    # TODO: raise an error here instead of `nil`
    return user.save ? user : nil
  end


  def ig_follow(ig_user)
    InstagramUser.first_or_create_account(ig_user)
    self.instagram_users << ig_user
  end
end
