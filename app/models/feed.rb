class Feed < ActiveRecord::Base
  # Associations ---------------------------------------------------------------
  has_and_belongs_to_many :au_users
  has_many :posts
  after_create :populate_posts

  # Validations---------------------------------------------
  validates :name, :platform, :platform_feed_id, presence: true

  # Scopes ---------------------------------------------------------------------
  scope :developer, -> { where(platform: "Developer") }
  scope :instagram, -> { where(platform: "Instagram") }
  scope :vimeo, -> { where(platform: "Vimeo") }

  def check_for_updates
    # query the API
    # save any new posts
    # delete any posts that stopped existing
      # privacy-- people might change the privacy stuff
      # deletion-- people might just delete something
  end

  # not sure where to put these
  FEED_URI_A = "https://api.instagram.com/v1/users/" # then user_id (for us: feed_id)
  FEED_URI_B = "/media/recent?client_id=#{ ENV["INSTAGRAM_CLIENT_ID"] }"

  def populate_posts
    if platform == "Instagram" || platform == "Developer"
      feed_url = FEED_URI_A + platform_feed_id.to_s + FEED_URI_B
      results = HTTParty.get(feed_url)
      posts = results["data"]
      posts.each do |post|
        maybe_valid_post = Post.create(create_instagram_post(post, self.id))
        # raise
      end

    elsif platform == "Vimeo"
      # TODO: handling for populating vimeo posts here

    end
  end

  private
    def create_instagram_post(post_data, feed_id)
      post_hash = {}
      post_hash[:description] = post_data["caption"]["text"] if post_data["caption"]
      post_hash[:content]     = post_data["images"]["low_resolution"]["url"]
      post_hash[:date_posted] = Time.at(post_data["created_time"].to_i)
      post_hash[:feed_id]     = feed_id
      return post_hash
    end
end
