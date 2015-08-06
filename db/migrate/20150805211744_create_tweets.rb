class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :tw_user_id_str
      t.string :tw_user_name_str
      t.string :tw_user_profile_image_url
      t.string :tw_user_screen_name
      t.string :tw_id_str
      t.string :tw_text
      t.string :tw_created_at
      t.integer :tw_retweet_count
      t.integer :tw_favorite_count

      t.timestamps null: false
    end
  end
end
