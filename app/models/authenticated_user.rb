class AuthenticatedUser < ActiveRecord::Base
  def self.create_with_omniauth(auth)
    create! do |authenticated_user|
      authenticated_user.provider = auth["provider"]
      authenticated_user.uid = auth["uid"]
      authenticated_user.name = auth["info"]["nickname"]
      authenticated_user.email = auth["info"]["email"]
      authenticated_user.avatar = auth["info"]["pictures"][0]["link"]
    end
  end
end
