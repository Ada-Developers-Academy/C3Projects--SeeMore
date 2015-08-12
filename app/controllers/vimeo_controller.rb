require "#{ Rails.root }/lib/vimeo_api"
include FriendFaceAPIs

class VimeoController < ApplicationController
  def results
    @query = params[:query]
    @results = VimeoAPI.vimeo_search(@query)
  end

  def individual_feed
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "Vimeo")

    if feed
      feed.update_feed
      @internal = true
      @posts = feed.posts.only_thirty
      @feed = feed

    else
      @posts = VimeoAPI.vimeo_feed(params[:feed_id])
      @feed_name = @posts.first["user"]["name"]
      flash.now[:error] = "This feed does not have any public posts." unless @posts
    end
  end

  def subscribe
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "Vimeo")

    unless feed
      feed_info = VimeoAPI.vimeo_feed_info(id)
      feed_attributes = create_feed_attributes(feed_info)
      feed = Feed.create(feed_attributes)
    end

    current_user.feeds << feed unless current_user.feeds.include?(feed)
    redirect_to :back
  end

  def unsubscribe
    feed_id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: feed_id, platform: "Vimeo")
    current_user.unsubscribe(feed.id)
    redirect_to :back
  end

  private
    def create_feed_attributes(feed_info)
      feed_hash = {}

      feed_hash[:name]             = feed_info["name"]
      feed_hash[:platform]         = "Vimeo"
      feed_hash[:platform_feed_id] = params[:feed_id]

      return feed_hash
    end
end
