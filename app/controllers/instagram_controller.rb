class InstagramController < ApplicationController
  SEARCH_URI = "https://api.instagram.com/v1/users/search?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }&count=10"
  FEED_URI_A = "https://api.instagram.com/v1/users/" # then user_id (for us: feed_id)
  FEED_URI_B = "/media/recent?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"

  def search
    # params: { instagram: { query: "vikshab" } }
    query = params.require(:instagram).require(:query)
    # => "vikshab"
    # query = params.require(:instagram).permit(:query)
    # => { query: "vikshab" }
    # query = "vikshab"

    redirect_to results_path(query)
  end

  def results
    @query = params[:query]
    search_url = SEARCH_URI + "&q=#{ @query }"
    results = HTTParty.get(search_url)
    @results = results["data"]
  end

  def individual_feed
    feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
    results = HTTParty.get(feed_url)
    @posts = results["data"]
    flash.now[:error] = "This feed does not have any public posts." unless @posts
  end

  def subscribe
    feed = Feed.find_by(platform_feed_id: params[:feed_id])
    # raise
    unless feed
      # raise
      feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
      results = HTTParty.get(feed_url)

      feed = Feed.create(create_feed_attributes_from_API_junk(results))

      posts = results["data"]
      posts.each do |post|
        maybe_valid_post = Post.create(create_post_params(post, feed))
        raise
      end
      raise
    end
    current_user.feeds << feed unless current_user.feeds.include?(feed)
  end

  private
    def create_feed_attributes_from_API_junk(results) # best variable name ever!
      feed_hash = {}
      feed_info = results["data"].first["caption"]["from"]
      feed_hash[:avatar]           = feed_info["profile_picture"]
      feed_hash[:name]             = feed_info["username"]
      feed_hash[:platform]         = "Instagram"
      feed_hash[:platform_feed_id] = params[:feed_id]
      return feed_hash
    end

    def create_post_params(post_data, feed)
      post_hash = {}
      post_hash[:description] = post_data["caption"]["text"]
      post_hash[:content]     = post_data["images"]["low_resolution"]["url"]
      post_hash[:date_posted] = Time.at(post_data["caption"]["created_time"].to_i)
      post_hash[:feed_id]     = feed.id
      return post_hash
    end
end
