class AddPostIdToPostModel < ActiveRecord::Migration
  def change
    add_column :posts, :post_id, :string
  end
end
