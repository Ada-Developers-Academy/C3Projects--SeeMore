class CreateJoinTableTweetUser < ActiveRecord::Migration
  def change
    create_join_table :tweets, :users do |t|
      t.index [:tweet_id, :user_id]
      t.index [:user_id, :tweet_id]
    end
  end
end
