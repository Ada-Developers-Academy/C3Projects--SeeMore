class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer :followee_id
      t.string :source
      t.string :native_created_at
      t.string :native_id
      t.string :embed_html

      t.timestamps null: false
    end
  end
end
