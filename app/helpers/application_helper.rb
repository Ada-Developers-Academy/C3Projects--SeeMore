module ApplicationHelper
  def user_or_guest
    session[:user_id] ? User.find(session[:user_id]).username : "guest"
  end

  def tw_following?(id)
    our_user = User.find(session[:user_id])
    matches = our_user.tw_users.where(tw_user_id_str: id)
    matches.exists?
  end

  def tw_user_lookup(tweet)
    TwUser.find(tweet.tw_user_id)
  end

  def tw_prettify(time)
    time = time.to_datetime
    time.strftime ("%c")
  end

end
