class AddLastPostIdToFollowees < ActiveRecord::Migration
  def change
    add_column :followees, :last_post_id, :string
  end
end
