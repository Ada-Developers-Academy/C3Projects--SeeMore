class ReformatTweetMediaTable < ActiveRecord::Migration
  def change
    rename_table :tweet_media, :media
    rename_column :media, :tweet_id, :post_id
  end
end
