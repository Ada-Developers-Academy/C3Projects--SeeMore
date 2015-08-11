class InstagramController < ApplicationController
  SEARCH_URI = "https://api.instagram.com/v1/users/search?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }&count=10"
  FEED_INFO_URI_A = "https://api.instagram.com/v1/users/" # then user_id (for us: feed_id)
  FEED_INFO_URI_B = "?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"
  FEED_URI_A = "https://api.instagram.com/v1/users/" # then user_id (for us: feed_id)
  FEED_URI_B = "/media/recent?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"

  def results # index ?
    @query = params[:query]
    search_url = SEARCH_URI + "&q=#{ @query }"
    results = HTTParty.get(search_url)
    @results = results["data"]
  end

  def individual_feed # show
    feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
    results = HTTParty.get(feed_url)
    @posts = results["data"]
    flash.now[:error] = "This feed does not have any public posts." unless @posts
  end

  def subscribe # new
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "instagram")

    unless feed
      feed_info_url = FEED_INFO_URI_A + id + FEED_INFO_URI_B
      feed_info_results = HTTParty.get(feed_info_url)
      feed = Feed.create(create_feed_attributes_from_API_junk(feed_info_results))
    end

    current_user.feeds << feed unless current_user.feeds.include?(feed)
    redirect_to root_path
  end

  private
    def create_feed_attributes_from_API_junk(results) # best variable name ever!
      feed_hash = {}
      feed_info = results["data"]
      feed_hash[:avatar]           = feed_info["profile_picture"] if feed_info["profile_picture"]
      feed_hash[:name]             = feed_info["username"]
      feed_hash[:platform]         = "Instagram"
      feed_hash[:platform_feed_id] = params[:feed_id]
      return feed_hash
    end
end
