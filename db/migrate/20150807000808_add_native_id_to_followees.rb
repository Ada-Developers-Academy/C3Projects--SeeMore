class AddNativeIdToFollowees < ActiveRecord::Migration
  def change
    add_column :followees, :native_id, :string
  end
end
