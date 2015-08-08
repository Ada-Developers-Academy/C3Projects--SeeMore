class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.string :twitter_id
      t.string :instagram_id
      t.string :profile_pic

      t.timestamps null: false
    end
  end
end
