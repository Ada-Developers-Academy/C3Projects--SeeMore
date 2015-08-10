class CreateInstagramUsers < ActiveRecord::Migration
  def change
    create_table :instagram_users do |t|
      t.string :username 
      t.string :profile_pic 
      t.string :ig_user_id 
      t.string :fullname 
      t.timestamps null: false
    end
  end
end
