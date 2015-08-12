require "#{ Rails.root }/lib/instagram_api"
include FriendFaceAPIs

class InstagramController < ApplicationController
  def results
    @query = params[:query]
    @results = InstagramAPI.instagram_search(@query)
  end

  def individual_feed
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "Instagram")

    if feed
      feed.update_feed
      @internal = true
      @posts = feed.posts.only_thirty

    else
      feed_info = InstagramAPI.instagram_feed_info(id)
      @feed_name = feed_info["username"]

      @posts = InstagramAPI.instagram_feed(id)
    end
  end

  def subscribe
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "Instagram")

    unless feed
      feed_info = InstagramAPI.instagram_feed_info(id)
      feed_attributes = create_feed_attributes(feed_info)
      feed = Feed.create(feed_attributes)
    end

    current_user.feeds << feed unless current_user.feeds.include?(feed)
    redirect_to :back
  end

  private
    def create_feed_attributes(feed_info)
      feed_hash = {}

      feed_hash[:avatar]           = feed_info["profile_picture"] if feed_info["profile_picture"]
      feed_hash[:name]             = feed_info["username"]
      feed_hash[:platform]         = "Instagram"
      feed_hash[:platform_feed_id] = params[:feed_id]

      return feed_hash
    end
end
