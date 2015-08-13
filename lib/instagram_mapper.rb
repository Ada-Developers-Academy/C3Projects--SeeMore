class InstagramMapper
  def self.get_posts(id, last_post_id)
    posts = InstagramApi.new.query_API_for_posts(id, last_post_id)

    remove_duplicate_post(posts, last_post_id)
  end

  # If there is a last_post_id,
  # the instagram API will retrieve the last_post again,
  # so we want to exclude the last post in the collection.
  # Otherwise return the whole collection (for newly followed users).
  def self.remove_duplicate_post(posts, last_post_id)
    last_post_id ? posts[0..-2] : posts
  end

  def self.format_params(post, followee)
    post_hash = {}
    link = post["link"]
    
    post_hash[:native_id] = post["id"]
    post_hash[:native_created_at] = convert_instagram_time(post["created_time"])
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = InstagramApi.new.embed_html_with_js(link)

    return post_hash
  end

  def self.convert_instagram_time(time)
    Time.at(time.to_i)
  end
end
