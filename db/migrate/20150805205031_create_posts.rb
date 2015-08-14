class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :description
      t.string :content
      t.datetime :date_posted
      t.integer :feed_id, null: false

      t.timestamps null: false
    end
  end
end
