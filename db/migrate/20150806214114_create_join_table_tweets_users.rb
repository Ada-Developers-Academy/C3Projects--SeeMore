class CreateJoinTableTweetsUsers < ActiveRecord::Migration
  def change
    create_join_table :tweets, :users do |t|
      t.index :tweet_id
      t.index :user_id
    end
  end
end
