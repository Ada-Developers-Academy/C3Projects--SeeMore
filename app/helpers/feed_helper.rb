module FeedHelper
  def vimeo_feed(feed_id)
    feed_url = vimeo_feed_url(feed_id)
  end

  def vimeo_feed_info(feed_id)
  end

  def vimeo_query(search_term)
    json_string_results = HTTParty.get(feed_url, :headers => vimeo_header)
    json_results = JSON.parse(json_string_results)
  end

  def vimeo_json_request(url)
    json_string_results = HTTParty.get(url, :headers => vimeo_header)
    json_results = JSON.parse(json_string_results)
  end

  private
    def vimeo_search_uri
      "https://api.vimeo.com/users?per_page=30&query="
    end

    def vimeo_feed_uri(feed_id)
      "https://api.vimeo.com/users/" + feed_id + "/videos?page=1&per_page=30"
    end

    def vimeo_header
      {
        "Accept" => "application/vnd.vimeo.*+json;version=3.2",
        "Authorization" => "bearer #{ ENV["VIMEO_ACCESS_TOKEN"] }"
      }
    end
end
