class User < ActiveRecord::Base


  # Validations
  validates_presence_of :name, :uid, :provider

  validates_uniqueness_of :name, :uid
end
