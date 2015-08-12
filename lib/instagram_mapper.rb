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
end
