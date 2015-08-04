class User < ActiveRecord::Base

  # Validations ----------------------------------------------
  # validates :email, presence: true
  # validates :username, presence: true
  validates :uid, presence: true
  validates :provider, presence: true


  def self.find_or_create_from_omniauth_developer(auth_hash)
    uid = auth_hash[:uid]
    provider = auth_hash[:provider]

    user = User.where(uid: uid, provider: provider).first_or_initialize
    user.email = auth_hash[:info][:email]
    user.username = auth_hash[:info][:username]
    return user.save ? user : nil # don't love this nil. would be useful to see the errors. what to do if someone authenticates at github but I couldn't create a valid record?
  end
end
