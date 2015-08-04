class User < ActiveRecord::Base
  
  # Validations ----------------------------------------------
  # validates :email, presence: true  
  # validates :username, presence: true  
  validates :uid, presence: true  
  validates :provider, presence: true  

end
