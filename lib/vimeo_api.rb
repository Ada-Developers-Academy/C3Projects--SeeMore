module FriendFaceAPIs
  class VimeoAPI
    require "httparty"

    # Vimeo public ---------------------------------------------------------------
    def self.vimeo_feed(feed_id)
      feed_id = feed_id.to_s
      feed_url = self.vimeo_feed_uri(feed_id)
      results = self.vimeo_json_request(feed_url)
      return results["data"]
    end

    def self.vimeo_feed_info(feed_id)
      feed_id = feed_id.to_s
      feed_url = self.vimeo_feed_base + feed_id
      results = self.vimeo_json_request(feed_url)
      return results
    end

    def self.vimeo_search(search_term)
      search_term.gsub!(/(\s+)/, "+")
      search_url = self.vimeo_search_uri + search_term
      results = self.vimeo_json_request(search_url)
      return results["data"]
    end


    private
      # Vimeo private ------------------------------------------------------------
      def self.vimeo_json_request(url)
        json_string_results = HTTParty.get(url, :headers => vimeo_header)
        json_results = JSON.parse(json_string_results)
      end

      def self.vimeo_search_uri
        "https://api.vimeo.com/users?per_page=30&query="
      end

      def self.vimeo_feed_base
        "https://api.vimeo.com/users/"
      end

      def self.vimeo_feed_uri(feed_id)
        self.vimeo_feed_base + feed_id + "/videos?page=1&per_page=30"
      end

      def self.vimeo_header
        {
          "Accept" => "application/vnd.vimeo.*+json;version=3.2",
          "Authorization" => "bearer #{ ENV["VIMEO_ACCESS_TOKEN"] }"
        }
      end
  end
end
