class InstagramClient
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"

  def self.user_search(search_term)
    results = HTTParty.get(INSTAGRAM_SEARCH_USERS_URI + "q=#{search_term}")
    return results["data"]
  end
end
