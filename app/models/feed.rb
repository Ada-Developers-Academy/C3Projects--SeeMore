class Feed < ActiveRecord::Base
  # Associations--------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts
  def save_feed
    feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
    results  = HTTParty.get(feed_url)
    feed_info  = results["data"].first["caption"]["from"]
    avatar   = feed_info["profile_picture"]
    name     = feed_info["username"]
    platform = "Instagram"
    platform_feed_id = params[:feed_id]
    feed = Feed.create(
      name: name,
      avatar: avatar,
      platform: platform,
      platform_feed_id: platform_feed_id
    )
    posts = results["data"]
    posts.each do |post|
      description = post["caption"]["text"]
      content = post["images"]["low_resolution"]["url"]
      date_posted = Time.at(post["caption"]["created_time"].to_i)
      Post.create(
        description: description,
        content: content,
        date_posted: date_posted,
        feed_id: feed.id
      )
    end
  end
end
