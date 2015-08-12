class AddColumnToTweetPosts < ActiveRecord::Migration
  def change
    add_column :tweet_posts, :post_url, :string
  end
end
