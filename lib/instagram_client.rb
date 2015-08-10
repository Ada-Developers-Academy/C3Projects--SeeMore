class InstagramClient
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"
  INSTAGRAM_FETCH_GRAMS_URI = "https://api.instagram.com/v1/users/"
  SEED_COUNT = 5

  def self.user_search(search_term)
    results = HTTParty.get(INSTAGRAM_SEARCH_USERS_URI + "q=#{search_term}")
    return results["data"]
  end

  def self.seed_grams(user_uid)
    result = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{user_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&count=#{SEED_COUNT}")
    return result["data"] # this returns an array of hashes with information
    # about the grams...each index in the array corresponds to a new gram
  end

  def self.update_grams(user_uid, last_gram_id)
    result = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{user_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&min_id=#{last_gram_id}")
    return result["data"]
  end
end
