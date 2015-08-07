class CreateGrams < ActiveRecord::Migration
  def change
    create_table :grams do |t|
      t.string :uid, null: false
      t.string :body
      t.string :photo_url, null: false
      t.datetime :gram_time, null: false
      t.integer :prey_id, null: false

      t.timestamps null: false
    end
  end
end
