class Post < ActiveRecord::Base
  # Associations--------------------------------------------
  belongs_to :feed
end
