module ApplicationHelper

  def tw_following?(id)
    # This checks to see if tweets by this twitter user exist
    matches = Tweet.find_by(tw_user_id_str: id)
    # Checks if there are any matches
    unless matches == nil
    # This checks if that collection of matches are associated with
    # the Creep Peep user
    matches.first.user_id == session[:user_id]
      # This conditional might not be necessary...
      # if matches.first.user_id == session[:user_id]
      #   return true
      # else
      #   return false
      # end
    else
      return false
    end
  end

end
