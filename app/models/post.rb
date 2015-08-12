class Post < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :followee_id, :source, :native_created_at, :native_id, presence: true

  # Associations ---------------------------------------------------------------
  belongs_to :followee

  # Scopes ---------------------------------------------------------------------
  scope :chron_sort, -> { order('native_created_at')}

  # this whole method minus the commented part would go in the Api Helper
  def self.process_new_posts(subscriptions)
    subscriptions.each do |subscription|
      followee = subscription.followee
      source = followee.source

      posts = get_posts_from_API(followee)

      # this should be a Post model method
      if posts && posts.count > 0      
        create_from_API(posts, followee, source)
        Followee.update_last_post_id!(posts, followee, source)
      end
    end
  end

  # this goes in API helper
  def self.get_posts_from_API(followee)
    last_post_id = followee.last_post_id
    source = followee.source

    case source
    when ApplicationController::TWITTER
      id = followee.native_id.to_i
      posts = TwitterApi.new.get_posts(id, last_post_id)
    when ApplicationController::INSTAGRAM
      id = followee.native_id
      posts = InstagramApi.new.get_posts(id, last_post_id)
    end

    posts
  end

  # stay in Post model
  def self.create_from_API(posts, followee, source)
    posts.each do |post|
      post_hash = post_params(post, followee, source)
      create(post_hash)
    end
  end

  # put in Api Helper
  def self.post_params(post, followee, source)
    case source
    when ApplicationController::TWITTER
      twitter_params(post, followee)
    when ApplicationController::INSTAGRAM
      instagram_params(post, followee)
    end
  end

  # put in TwitterMapper
  def self.twitter_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post.id
    post_hash[:native_created_at] = post.created_at
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = TwitterApi.new.embed_html_without_js(post.id)

    return post_hash
  end

  # put in InstagramMapper
  def self.instagram_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post["id"]
    post_hash[:native_created_at] = InstagramApi.convert_instagram_time(post["created_time"])
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = InstagramApi.new.embed_html_with_js(post)

    return post_hash
  end
end
