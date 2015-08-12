module FriendFaceAPIs
  class InstagramAPI
    require "httparty"

    # Instagram public -----------------------------------------------------------
    def self.instagram_feed(feed_id)
      feed_id = feed_id.to_s
      feed_url = self.instagram_feed_uri(feed_id)
      results = self.instagram_request(feed_url)
      return results["data"]
    end

    def self.instagram_feed_info(feed_id)
      feed_id = feed_id.to_s
      feed_url = self.instagram_feed_info_uri(feed_id)
      results = self.instagram_request(feed_url)
      return results["data"]
    end

    def self.instagram_search(search_term)
      search_term.gsub!(/(\s+)/, "+")
      search_url = self.instagram_search_uri(search_term)
      results = self.instagram_request(search_url)
      return results["data"]
    end

    private
      # Instagram private --------------------------------------------------------
      def self.instagram_request(url)
        results = HTTParty.get(url)
      end

      def self.instagram_search_uri(search_term)
        "https://api.instagram.com/v1/users/search?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }&count=30&q=#{ search_term }"
      end

      def self.instagram_feed_base
        "https://api.instagram.com/v1/users/"
      end

      def self.instagram_feed_info_uri(feed_id)
        self.instagram_feed_base + feed_id + self.instagram_cid
      end

      def self.instagram_feed_uri(feed_id)
        self.instagram_feed_base + feed_id + "/media/recent" + self.instagram_cid
      end

      def self.instagram_cid
        "?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"
      end
  end
end
