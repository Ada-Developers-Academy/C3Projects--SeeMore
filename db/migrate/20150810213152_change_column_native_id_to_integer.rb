class ChangeColumnNativeIdToInteger < ActiveRecord::Migration
  def change
    change_column :followees, :native_id, :integer
  end

  def change
    change_column :posts, :native_id, :integer
  end
end
