module ApplicationHelper
  def tw_following?(id)
    our_user = User.find(session[:user_id])
    matches = our_user.tw_users.where(tw_user_id_str: id)
    matches.exists?
  end
end
