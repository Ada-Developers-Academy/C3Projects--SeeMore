class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :username, null: false
      t.datetime :posted_at, null: false
      t.string :text
      t.string :image
      t.string :content_id, null: false
      t.references :subscription, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
