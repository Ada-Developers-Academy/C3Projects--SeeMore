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
    unless feed
      feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
      results  = HTTParty.get(feed_url)
      raise
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
    current_user.feeds << feed unless current_user.feeds.include?(feed)
  end
end
