module ApplicationHelper
  def tw_following?(id)
    # This checks to see if tweets by this twitter user exist
    matches = TwUser.find_by(tw_user_id_str: id)
    # Checks if there are any matches
    unless matches == nil
    # This checks the twitter user is associated with the Creep Peep user
    matches.users.first.id == session[:user_id]
    # if match, this returns true
    else
      return false
    end
  end
end
