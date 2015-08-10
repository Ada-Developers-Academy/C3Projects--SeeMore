class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :uid, null: false
      t.string :body
      t.datetime :tweet_time, null: false
      t.integer :prey_id, null: false

      t.timestamps null: false
    end
  end
end
