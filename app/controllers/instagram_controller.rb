class InstagramController < ApplicationController
  # THING_URI = "https://api.instagram.com/v1/media/popular?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"
  SEARCH_URI = "https://api.instagram.com/v1/users/search?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }&count=10"
  FEED_URI_A = "https://api.instagram.com/v1/users/" # then user_id
  FEED_URI_B = "/media/recent?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"

  def results
    # params: { instagram: { query: "vikshab" } }
    query = params.require(:instagram).require(:query)
    # => "vikshab"
    # query = params.require(:instagram).permit(:query)
    # => { query: "vikshab" }
    # query = "vikshab"
    search_url = SEARCH_URI + "&q=#{ query }"
    results = HTTParty.get(search_url)
    @matches = results["data"]
  end

  def individual_feed
    feed_url = FEED_URI_A + params[:feed_id] + FEED_URI_B
    results = HTTParty.get(feed_url)
    @posts = results["data"]
  end
end
