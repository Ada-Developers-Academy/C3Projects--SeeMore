class Post < ActiveRecord::Base
  # Associations
  belongs_to :subscription
  has_many :users, through: :subscriptions

  #Validations
  validates_presence_of :username, :posted_at, :content_id
end
