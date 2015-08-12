class InstagramApi
  INSTA_URI = "https://api.instagram.com/v1/users/search?q="
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="

  # the number of posts to get
  # the first time you update your feed after following someone
  FIRST_POSTS = "5"

  def user_search(query, count)
    response = HTTParty.get(INSTA_URI + query + "&count=" + count.to_s + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")

    return response["data"]
  end

  def get_embed_html(post)
    link = post["link"]
    response = HTTParty.get(INSTA_OEMBED_URI + link)

    return response["html"]
  end

  def get_posts(id, last_post_id)
    number_of_posts = last_post_id ? "min_id=#{last_post_id}" : "count=#{FIRST_POSTS}"
    response = HTTParty.get(
      INSTA_USER_POSTS_URI + id + 
      "/media/recent/?" + number_of_posts + 
      "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"]
    )
  end
end
