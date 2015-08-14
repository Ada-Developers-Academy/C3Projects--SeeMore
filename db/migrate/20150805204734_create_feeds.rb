class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.string :avatar
      t.string :platform, null: false
      t.integer :platform_feed_id, null: false

      t.timestamps null: false
    end
  end
end
