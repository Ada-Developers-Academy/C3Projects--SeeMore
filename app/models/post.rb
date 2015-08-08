class Post < ActiveRecord::Base
  # Associations
  belongs_to :subcription
  has_many :users, through: :subscriptions

  #Validations
  validates_presence_of :username, :posted_at, :content_id
end
