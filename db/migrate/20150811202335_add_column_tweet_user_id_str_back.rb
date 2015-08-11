class AddColumnTweetUserIdStrBack < ActiveRecord::Migration
  def change
    add_column :tweets, :tw_user_id_str, :string
  end
end
