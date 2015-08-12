class RenameTable < ActiveRecord::Migration
  def change
    rename_table :instagram_users_and_users, :instagram_users_users
  end
end
