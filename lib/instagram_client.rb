require 'api_helpers'

class InstagramClient
  INSTAGRAM_SEARCH_USERS_URI = "https://api.instagram.com/v1/users/search?client_id=#{ENV["INSTAGRAM_CLIENT_ID"]}&"
  INSTAGRAM_FETCH_GRAMS_URI = "https://api.instagram.com/v1/users/"

  def self.user_search(search_term)
    response = HTTParty.get(INSTAGRAM_SEARCH_USERS_URI + "q=#{search_term}")
    InstagramHelper.format_many_prey(response["data"])
  end

  def self.seed_grams(prey_uid, seed_count)
    response = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{prey_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&count=#{seed_count}")
    InstagramHelper.format_many_grams(response["data"])
  end

  def self.update_grams(prey_uid, last_gram_uid)
    response = HTTParty.get(INSTAGRAM_FETCH_GRAMS_URI + "#{prey_uid}/media/recent/?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}&min_id=#{last_gram_uid}")
    InstagramHelper.format_many_grams(response["data"])
  end
end
