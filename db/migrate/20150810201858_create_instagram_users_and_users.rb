class CreateInstagramUsersAndUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users_and_users, id: false do |t|
      t.belongs_to :instagram_user, index: true
      t.belongs_to :user, index: true
    end
  end
end
