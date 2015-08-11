class InstagramClient
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"
  INSTAGRAM_FETCH_GRAMS_URI = "https://api.instagram.com/v1/users/"

  def self.user_search(search_term)
    results = HTTParty.get(INSTAGRAM_SEARCH_USERS_URI + "q=#{search_term}")
    return results["data"]
  end

  def self.seed_grams(prey_uid, seed_count)
    result = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{prey_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&count=#{seed_count}")
    return result["data"] # this returns an array of hashes with information
    # about the grams...each index in the array corresponds to a new gram
  end

  def self.update_grams(prey_uid, last_gram_uid)
    result = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{prey_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&min_id=#{last_gram_uid}")
    return result["data"]
  end
end
