# require & include the API wrappers
require "#{ Rails.root }/lib/vimeo_api"
require "#{ Rails.root }/lib/instagram_api"
include FriendFaceAPIs

class Feed < ActiveRecord::Base
  # Callbacks ------------------------------------------------------------------
  after_create :populate_posts

  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts, dependent: :destroy # FIXME: test this Jeri

  # Validations-----------------------------------------------------------------
  validates :name, :platform, :platform_feed_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :developer, -> { where(platform: "Developer") }
  scope :instagram, -> { where(platform: "Instagram") }
  scope :vimeo, -> { where(platform: "Vimeo") }

  # Instance Methods -----------------------------------------------------------

  # Creating feeds ------------

  def populate_posts
    if platform == "Instagram" || platform == "Developer"
      populate_instagram_feed
    elsif platform == "Vimeo"
      populate_vimeo_feed
    end
  end

  def populate_instagram_feed
    posts = InstagramAPI.instagram_feed(platform_feed_id)
    posts.each do |post|
      Post.create(create_instagram_post(post, self.id))
    end
  end

  def populate_vimeo_feed
    posts = VimeoAPI.vimeo_feed(platform_feed_id)
    posts.each do |post|
      Post.create(create_vimeo_post(post, self.id))
    end
  end

  # Updating feeds -------------

  def update_feed # FIXME: test update_feed
    if (platform == "Instagram") || (platform == "Developer")
      update_instagram_feed
    elsif platform == "Vimeo"
      update_vimeo_feed
    end
  end

  def update_instagram_feed
    # grab the dusty, old posts
    feed_posts = self.posts
    feed_post_ids = feed_posts.map { |post| post.post_id }

    # query the API to get new posts
    new_posts = InstagramAPI.instagram_feed(platform_feed_id)

    # create & update new posts from data where appropriate
    updated_posts = []
    new_posts.each do |post|
      post_id = post["id"]

      if feed_post_ids.include? post_id
        new_post = Post.find_by(post_id: post_id)
        new_post.update(create_instagram_post(post, self.id))
      else
        new_post = Post.create(create_instagram_post(post, self.id))
      end

      updated_posts.push(new_post)
    end

    # delete any posts that are no longer present
    feed_posts = self.posts
    feed_posts.each do |post|
      post.destroy unless updated_posts.include? post
    end
  end

  def update_vimeo_feed
    # grab the dusty, old posts
    feed_posts = self.posts
    feed_post_ids = feed_posts.map { |post| post.post_id }

    # query the API to get new posts
    new_posts = VimeoAPI.vimeo_feed(platform_feed_id)

    # create & update new posts from data where appropriate
    updated_posts = []
    new_posts.each do |post|
      post_id = post["id"]
      if feed_post_ids.include? post_id
        new_post = Post.find_by(post_id: post_id)
        new_post.update(create_vimeo_post(post, self.id))
      else
        new_post = Post.create(create_vimeo_post(post, self.id))
      end

      updated_posts.push(new_post)
    end

    # delete any posts that are no longer present
    feed_posts = self.posts
    feed_posts.each do |post|
      post.destroy unless updated_posts.include? post
    end
  end

  # Private methods ------------------------------------------------------------
  private
    def create_instagram_post(post_data, feed_id)
      post_hash = {}

      # do a little extra preparation on one piece of post data
      date_posted = Time.at(post_data["created_time"].to_i)

      # now assign everything to the hash
      post_hash[:post_id]     = post_data["id"] # post id from instagram
      post_hash[:description] = post_data["caption"]["text"] if post_data["caption"]
      post_hash[:content]     = post_data["images"]["low_resolution"]["url"]
      post_hash[:likes]       = post_data["likes"]["count"]
      post_hash[:date_posted] = date_posted
      post_hash[:feed_id]     = feed_id # feed id from local feed object
      return post_hash
    end

    def create_vimeo_post(post_data, feed_id)
      post_hash = {}

      # do a little extra preparation on a couple pieces of post data
      post_id = VimeoController.helpers.grab_id(post_data)
      content = VimeoController.helpers.resize_video(post_data)

      # now assign everything to the hash
      post_hash[:post_id]     = post_id # post id from vimeo
      post_hash[:content]     = content # this is iframe video embedding code
      post_hash[:likes]       = post_data["metadata"]["connections"]["likes"]["total"]
      post_hash[:name]        = post_data["name"]
      post_hash[:description] = post_data["description"] # FIXME: in description, if description nil we can just put name
      post_hash[:date_posted] = post_data["created_time"]
      post_hash[:feed_id]     = feed_id # feed id from local feed object

      return post_hash
    end
end
