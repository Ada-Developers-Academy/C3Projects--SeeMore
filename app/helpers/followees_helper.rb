module FolloweesHelper
  def private_user?(user_id)
    InstagramApi.private_user?(user_id)
  end

  def already_following?(followee_id)
    @current_user.followees.find_by(native_id: followee_id) ? true : false
  end
end
