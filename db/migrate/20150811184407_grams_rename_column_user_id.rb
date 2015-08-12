class GramsRenameColumnUserId < ActiveRecord::Migration
  def change
    rename_column :grams, :user_id, :instagram_user_id
  end
end
