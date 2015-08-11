class RemoveColumnFromTweet < ActiveRecord::Migration
  def change
    remove_column :tweets, :user_id, :integer
  end
end
