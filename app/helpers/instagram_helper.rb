module InstagramHelper
  def user_already_instagram?(platform_feed_id)
    feed = Feed.find_by(platform_feed_id: platform_feed_id.to_i, platform: "Instagram")
    if feed
      return feed.au_users.include? current_user
    else
      return nil
    end
  end
end
