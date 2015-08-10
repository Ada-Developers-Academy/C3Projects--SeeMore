class CreateInstagramUsersAndUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users_and_users, id: false do |t|
      t.integer :instagram_user
      t.integer :user
    end
  end
end
