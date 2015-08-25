class CreateTwUsers < ActiveRecord::Migration
  def change
    create_table :tw_users do |t|
      t.string :tw_user_id_str
      t.string :user_name
      t.string :profile_image_url
      t.string :screen_name
      t.timestamps null: false
    end
  end
end
