class Post < ActiveRecord::Base
  # Validations ----------------------------------------------------------------
  validates :followee_id, :source, :native_created_at, :native_id, presence: true

  # Associations ---------------------------------------------------------------
  belongs_to :followee

  # Scopes ---------------------------------------------------------------------
  scope :chron_sort, -> { order('native_created_at')}

  def self.create_posts_and_update_followee(posts, followee, source)
    if posts && posts.count > 0
      create_from_API(posts, followee, source)
      Followee.update_last_post_id!(posts, followee, source)
    end
  end

  def self.create_from_API(posts, followee, source)
    posts.each do |post|
      post_hash = ApiHelper.post_params(post, followee, source)
      create(post_hash)
    end
  end
end
