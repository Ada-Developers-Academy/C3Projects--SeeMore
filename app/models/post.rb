class Post < ActiveRecord::Base
  # Associations
  belongs_to :subscription
  has_many :users, through: :subscription

  #Validations
  validates_presence_of :username, :posted_at, :content_id, :subscription_id
end
