class TwUser < ActiveRecord::Base
  # Associations
  has_and_belongs_to_many :users
  has_many :tweets
end
