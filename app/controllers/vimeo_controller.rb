class VimeoController < ApplicationController
  SEARCH_URI = "https://api.vimeo.com/users?per_page=30&query="
  FEED_INFO_URI = "https://api.vimeo.com/users/"
  TOKEN_HEADER = {
    "Accept" => "application/vnd.vimeo.*+json;version=3.2",
    "Authorization" => "bearer #{ ENV["VIMEO_ACCESS_TOKEN"] }"
  }

  BASE_URI = "https://api.vimeo.com/users/" # vm's user_id == our feed_id
  FEED_END_URI = "/videos?page=1&per_page=30"


  def results # index ?
    @query = params[:query]

    results = JSON.parse(HTTParty.get(SEARCH_URI + @query + "&sort=relevant", :headers => TOKEN_HEADER ))
    @results = results["data"]
  end

  def individual_feed # show
    feed_info_url = BASE_URI + params[:feed_id] + FEED_END_URI
    json_string_results = HTTParty.get(feed_info_url, :headers => TOKEN_HEADER)
    json_results = JSON.parse(json_string_results)

    @posts = json_results["data"]
    flash.now[:error] = "This feed does not have any public posts." unless @posts
  end

  def subscribe # new
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
      # FIXME: Brenna's magic avatar thing
      # feed_hash[:avatar]           = feed_info["profile_picture"] if feed_info["profile_picture"]
      feed_hash[:name]             = feed_info["name"]
      feed_hash[:platform]         = "Vimeo"
      feed_hash[:platform_feed_id] = params[:feed_id]
      return feed_hash
    end
end
