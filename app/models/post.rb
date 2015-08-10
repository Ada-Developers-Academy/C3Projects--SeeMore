class Post < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :followee_id, :source, :native_created_at, :native_id, presence: true

  # Associations ---------------------------------------------------------------
  belongs_to :followee

  # Scopes ---------------------------------------------------------------------
  scope :chron_sort, -> { order('native_created_at')}

  def self.twitter_create(post)
  end

  def self.instagram_create(post)
    post = Post.new
    post.followee_id
    post.source
    post.native_created_at
    post.native_id
    post.embed_html

    post.save
  end
end
