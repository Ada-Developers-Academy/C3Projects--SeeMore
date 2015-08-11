class VimeoController < ApplicationController
   SEARCH_URI = "https://api.vimeo.com/users?per_page=30&query="
   FEED_INFO_URI = "https://api.vimeo.com/users/"
   TOKEN_HEADER = {
                    "Accept" => "application/vnd.vimeo.*+json;version=3.2",
                    "Authorization" => "bearer #{ ENV["VIMEO_ACCESS_TOKEN"] }"
                  }

  def results # FIXME: add a helper method to take care of all this splitting to get user_ids & video_ids
    @query = params[:query]

    auth = JSON.parse(HTTParty.get(SEARCH_URI + @query + "&sort=relevant", :headers => TOKEN_HEADER ))
    @results = auth["data"]
  end

  def subscribe
    id = params[:feed_id]
    feed = Feed.find_by(platform_feed_id: id, platform: "vimeo")

    unless feed
      feed_info_url = FEED_INFO_URI + id
      json_string_results = HTTParty.get(feed_info_url, :headers => TOKEN_HEADER)
      json_results = JSON.parse(json_string_results)
      feed = Feed.create(create_feed_attributes(json_results))
    end

    current_user.feeds << feed unless current_user.feeds.include?(feed)
    redirect_to root_path
  end

  private
    def create_feed_attributes(results)
      feed_hash = {}
      feed_info = results
      # feed_hash[:avatar]           = feed_info["profile_picture"] if feed_info["profile_picture"]
      feed_hash[:name]             = feed_info["name"]
      # raise
      feed_hash[:platform]         = "Vimeo"
      feed_hash[:platform_feed_id] = params[:feed_id]
      return feed_hash
    end
end
