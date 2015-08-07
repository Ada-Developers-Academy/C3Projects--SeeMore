class User < ActiveRecord::Base
  # Associations
  has_many :tweets
  #Validations
  validates :username,:email,  presence: true

 #Methods

  #  def self.find_or_create_from_omniauth(auth_hash)

  #   auth_uid = auth_hash["uid"]
  #   auth_provider = auth_hash["provider"]

  #   user = User.where(uid: auth_uid, provider: auth_provider).first_or_initialize
  #   user.email = auth_hash["info"]["email"]
  #   user.username = auth_hash["info"]["username"]

  #   return user.save ? user : nil #(could also raise an error here)
  # end

end
