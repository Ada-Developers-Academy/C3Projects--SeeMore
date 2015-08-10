class CreateJoinTableTweetsUsers < ActiveRecord::Migration
  def change
    create_join_table :tweets, :users do |t|
      t.index [:tweet_id, :user_id], unique: true
    end
  end
end
