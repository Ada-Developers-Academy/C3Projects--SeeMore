class TwitterMapper
  # put in TwitterMapper
  def self.format_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post.id
    post_hash[:native_created_at] = post.created_at
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = TwitterApi.new.embed_html_without_js(post.id)

    return post_hash
  end
end
