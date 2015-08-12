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

  def embed_html_with_js(post)
    link = post["link"]
    response = HTTParty.get(INSTA_OEMBED_URI + link)

    return response["html"]
  end

  def get_posts(id, last_post_id)
    posts = query_API_for_posts(id, last_post_id)

    remove_duplicate_post(posts, last_post_id)
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

  def assign_number_of_posts(last_post_id)
    last_post_id ? "min_id=#{last_post_id}" : "count=#{FIRST_POSTS}"
  end

  def remove_duplicate_post(posts, last_post_id)
    # If there is a last_post_id,
    # the instagram API will retrieve the last_post again,
    # so exclude the last post in the collection.
    # Otherwise return the whole collection (for newly followed users).
    posts_retrieved_from_old_user?(posts, last_post_id) ? posts[0..-2] : posts
  end

  def posts_retrieved_from_old_user?(posts, last_post_id)
    # If the retrieved posts collection is not nil, not empty, 
    # and there is a last_post_id.
    true if posts && posts.count > 0 && last_post_id
  end

  def self.convert_instagram_time(time)
    Time.at(time.to_i)
  end
end
