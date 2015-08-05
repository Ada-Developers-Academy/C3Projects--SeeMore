class User < ActiveRecord::Base
  # Associations--------------------------------------------
  has_and_belongs_to_many :feeds
  has_many :posts, through: :feeds
end
