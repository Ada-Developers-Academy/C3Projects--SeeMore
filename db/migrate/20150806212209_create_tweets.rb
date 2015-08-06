class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :username, null: false
      t.string :provider_id, null: false

      t.timestamps null: false
    end
  end
end
