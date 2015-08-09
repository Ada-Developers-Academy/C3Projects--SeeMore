class CreateTweetPosts < ActiveRecord::Migration
  def change
    create_table :tweet_posts do |t|
      t.integer :post_id
      t.datetime :posted_at
      t.text :text
      t.string :media_url
      t.integer :tweet_id

      t.timestamps null: false
    end
  end
end
