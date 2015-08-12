class InstagramApi
  INSTA_URI = "https://api.instagram.com/v1/users/search?q="
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  INSTA_USER_DETAILS_URI = "https://api.instagram.com/v1/users/"

  # the number of posts to get
  # the first time you update your feed after following someone
  FIRST_POSTS = "1"

  def user_search(query, count)
    response = HTTParty.get(INSTA_URI + query + "&count=" + count.to_s + "&access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")

    return response["data"]
  end

  def private_user?(user_id)
    response = HTTParty.get(INSTA_USER_DETAILS_URI + "#{user_id}" + "/relationship?access_token=#{ENV["INSTAGRAM_ACCESS_TOKEN"]}")
    privacy_boolean = response["data"]["target_user_is_private"]

    return privacy_boolean
  end

  def embed_html_with_js(post)
    link = post["link"]
    response = HTTParty.get(INSTA_OEMBED_URI + link)

    return response["html"]
  end

  def query_API_for_posts(id, last_post_id)
    number_of_posts_query = assign_number_of_posts(last_post_id)

    response = HTTParty.get(
      INSTA_USER_POSTS_URI + id +
      "/media/recent/?" + number_of_posts_query +
      "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"]
    )
    posts = response["data"]
  end

  private
  ### we're leaving this here because it is called by #get_posts above
  ### and we don't want to create a dependency in this class on the InstagramMapper class
  def assign_number_of_posts(last_post_id)
    last_post_id ? "min_id=#{last_post_id}" : "count=#{FIRST_POSTS}"
  end
end
