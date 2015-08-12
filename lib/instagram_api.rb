class InstagramApi
  INSTA_URI = "https://api.instagram.com/v1/users/search?q="

  def user_search(query, count)
    response = HTTParty.get(INSTA_URI + query + "&count=" + count.to_s + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    return response["data"]
  end
end
