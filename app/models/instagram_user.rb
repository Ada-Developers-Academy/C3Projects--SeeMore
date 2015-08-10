class InstagramUser < ActiveRecord::Base
  #Associations
  has_and_belongs_to_many :users

# Methods ----------------------------------------------------------------------
  def self.first_or_create_account(ig_user)
  end
end
