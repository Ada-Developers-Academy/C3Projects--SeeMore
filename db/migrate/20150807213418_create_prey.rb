class CreatePrey < ActiveRecord::Migration
  def change
    create_table :prey do |t|
      t.string :name
      t.string :username
      t.string :provider, null: false
      t.string :uid, null: false
      t.string :photo_url
      t.string :profile_url

      t.timestamps null: false
    end
  end
end
