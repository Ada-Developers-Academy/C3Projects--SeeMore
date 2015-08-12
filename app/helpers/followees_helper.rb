module FolloweesHelper
  def private_user?(user_id)
    InstagramApi.private_user?(user_id)
  end
end
