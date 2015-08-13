module FolloweesHelper
  def private_user?(user_id)
    InstagramApi.new.private_user?(user_id)
  end

  def currently_following?(native_id)
    followee = Followee.find_by(native_id: native_id)

    if followee
      @current_user.subscriptions.active_for_this_followee(followee.id).empty? ? false : true
    else
      return false
    end 
  end
end
