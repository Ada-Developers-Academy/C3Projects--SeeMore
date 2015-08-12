class CreateGrams < ActiveRecord::Migration
  def change
    create_table :grams do |t|
      t.string :tags
      t.string :type
      t.string :created_time
      t.string :link
      t.integer :likes
      t.string :image_url
      t.string :caption
      t.string :ig_id
      t.string :ig_username 
      t.string :ig_user_pic
      t.string :ig_user_id
      t.string :ig_user_fullname
      t.integer :user_id
      t.timestamps null: false
    end
  end
end

