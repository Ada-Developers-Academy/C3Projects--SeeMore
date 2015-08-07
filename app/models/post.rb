class Post < ActiveRecord::Base
  # Associations--------------------------------------------
  belongs_to :feed

  # Validations---------------------------------------------
  validates :description, :content, :date_posted, :feed_id, presence: true
end
