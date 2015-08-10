class CreateInstagramPosts < ActiveRecord::Migration
  def change
    create_table :instagram_posts do |t|
      t.string :post_id, null: false
      t.integer :instagram_id, null: false
      t.index :instagram_id

      t.timestamps null: false
    end
  end
end
