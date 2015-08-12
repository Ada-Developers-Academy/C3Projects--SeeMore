class AddImageUrlToInstagramPosts < ActiveRecord::Migration
  def change
    add_column :instagram_posts, :image_url, :string
    add_column :instagram_posts, :post_url, :string
    add_column :instagram_posts, :posted_at, :datetime
    add_column :instagram_posts, :caption, :text
  end
end
