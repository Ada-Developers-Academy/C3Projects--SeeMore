class Feed < ActiveRecord::Base
  # Associations--------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts

  def check_for_updates
    # query the API
    # save any new posts
    # delete any posts that stopped existing
      # privacy-- people might change the privacy stuff
      # deletion-- people might just delete something
  end
end
