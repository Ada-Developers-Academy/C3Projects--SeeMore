class Post < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  
  # Associations ---------------------------------------------------------------
  belongs_to :followee
end
