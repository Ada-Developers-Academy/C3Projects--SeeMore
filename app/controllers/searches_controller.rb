require 'httparty'

class SearchesController < ApplicationController
  TWITTER_SEARCH_URI = "https://api.twitter.com/1.1/users/search.json?"

  def index
    if params[:search_twitter]
      response = HTTParty.get(TWITTER_SEARCH_URI + "q=#{@search_twitter}", header)
      raise


    end
  end
end

# OAuth oauth_consumer_key="DC0sePOBbQ8bYdC8r4Smg",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1438816465",oauth_nonce="1263838656",oauth_version="1.0",oauth_token="2437392751-3MV5020hWnvwMLVIQkSc0k2EaXPT4yIOQhogZ8n",oauth_signature="DWWM2X%2FmQ4Re5n2Ce2iuV%2FQ6ZKc%3D"
#
# OAuth oauth_consumer_key="DC0sePOBbQ8bYdC8r4Smg",oauth_signature_method="HMAC-SHA1",oauth_timestamp="1438816569",oauth_nonce="911714404",oauth_version="1.0",oauth_token="2437392751-3MV5020hWnvwMLVIQkSc0k2EaXPT4yIOQhogZ8n",oauth_signature="xlxg8r2jtzT1ND3GknybS9W68rE%3D"
