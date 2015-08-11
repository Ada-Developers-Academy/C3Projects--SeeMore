class InstagramUser < ActiveRecord::Base
  #Associations
  has_and_belongs_to_many :users
  has_many :grams

# Methods ----------------------------------------------------------------------
  def self.first_or_create_account(ig_user)
    username = ig_user["username"]
    account = InstagramUser.where(username: username).first_or_initialize
    account.username = ig_user["username"]
    account.profile_pic = ig_user["profile_picture"]
    account.fullname = ig_user["full_name"]
    account.ig_user_id = ig_user["id"]

    return account.save ?  account : nil
  end
end
