class RemoveColumnsFromTweets < ActiveRecord::Migration
  def change
    remove_column :tweets, :tw_user_id_str, :string
    remove_column :tweets, :tw_user_name_str, :string
    remove_column :tweets, :tw_user_profile_image_url, :string
    remove_column :tweets, :tw_user_screen_name, :string
  end
end
