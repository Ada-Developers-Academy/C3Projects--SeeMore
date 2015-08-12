class AddForeignKeyTwUserIdToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :tw_user_id, :integer
  end
end
