class Feed < ActiveRecord::Base
  # Callbacks ------------------------------------------------------------------
  after_create :populate_posts

  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts

  # Feed URI constants ---------------------------------------------------------
  # TODO: consider whether this should remain as media/recent. just realized there might be a longer feed available.
  INSTAGRAM_BASE_URI = "https://api.instagram.com/v1/users/" # ig's user_id == our feed_id
  INSTAGRAM_FEED_END_URI = "/media/recent?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"

  # Validations-----------------------------------------------------------------
  validates :name, :platform, :platform_feed_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :developer, -> { where(platform: "developer") }
  scope :instagram, -> { where(platform: "instagram") }
  scope :vimeo, -> { where(platform: "vimeo") }

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
    feed_url = INSTAGRAM_BASE_URI + platform_feed_id.to_s + INSTAGRAM_FEED_END_URI
    results = HTTParty.get(feed_url)
    posts = results["data"]
    posts.each do |post|
      maybe_valid_post = Post.create(create_instagram_post(post, self.id))
    end
  end

  def populate_vimeo_feed
    feed_url = VIMEO_BASE_URI + platform_feed_id.to_s + VIMEO_FEED_END_URI
    json_string_results = HTTParty.get(feed_url, :headers => VIMEO_TOKEN_HEADER )
    json_results = JSON.parse(json_string_results)
    posts = json_results["data"]
    posts.each do |post|
      maybe_valid_post = Post.create(create_vimeo_post(post, self.id))
    end
  end

  # Updating feeds -------------

  def check_for_updates
    if platform == "instagram" || platform == "developer"
      update_instagram_feed
    elsif platform == "vimeo"
      update_vimeo_feed
    else
      update_instagram_feed
    end
  end

  def update_instagram_feed
    # FIXME: this doesn't handle for posts that have been edited
    # FIXME continued: it only handles for posts that have been deleted
    feed_posts = self.posts
    feed_post_ids = feed_posts.map { |post| post.post_id }

    # query the API
    feed_url = INSTAGRAM_BASE_URI + platform_feed_id.to_s + INSTAGRAM_FEED_END_URI
    results = HTTParty.get(feed_url)
    new_posts = results["data"]

    # create new posts from data
    updated_posts = []
    new_posts.each do |post|
      post_id = post["id"]
      new_post = Post.create(create_instagram_post(post, self.id)) unless feed_post_ids.include? post_id
      updated_posts.push(new_post)
    end

    # delete any posts that are no longer present # this doesn't seem to work right :(
    # feed_posts.each do |post|
    #   unless updated_posts.include? post
    #     post.destroy
    #   end
    # end
  end

  def update_vimeo_feed
    # query the API
    # save any new posts
    # update any posts that changed
      # maybe there was a typo, etc
    # delete any posts that stopped existing
      # privacy-- people might change the privacy stuff
      # deletion-- people might just delete something
  end

  # Private methods ------------------------------------------------------------
  private
    def vimeo_feed_info(feed_id)
    end

    def vimeo_feed(feed_id)
    end

    def create_instagram_post(post_data, feed_id)
      post_hash = {}
      post_hash[:post_id]     = post_data["id"] # post id from instagram
      post_hash[:description] = post_data["caption"]["text"] if post_data["caption"]
      post_hash[:content]     = post_data["images"]["low_resolution"]["url"]
      post_hash[:likes]       = post_data["likes"]["count"]
      post_hash[:date_posted] = Time.at(post_data["created_time"].to_i)
      post_hash[:feed_id]     = feed_id # feed id from local feed object
      return post_hash
    end

    def create_vimeo_post(post_data, feed_id)
      post_hash = {}

      post_id = VimeoController.helpers.grab_id(post_data)
      post_hash[:post_id]     = post_id # post id from vimeo

      content = VimeoController.helpers.resize_video(post_data)
      post_hash[:content]     = content # this is iframe video embedding code

      post_hash[:name]        = post_data["name"]
      post_hash[:description] = post_data["description"] # FIXME: in description, if description nil we can just put name
      post_hash[:date_posted] = post_data["created_time"]
      post_hash[:feed_id]     = feed_id # feed id from local feed object

      return post_hash
    end
end
