class CreateTweetMedia < ActiveRecord::Migration
  def change
    create_table :tweet_media do |t|
      t.string :url, null: false
      t.integer :tweet_id, null: false, index: true

      t.timestamps null: false
    end
  end
end
