class CreateTwiSubscriptions < ActiveRecord::Migration
  def change
    create_table :twi_subscriptions do |t|
      t.string :twitter_id
      t.string :twitter_handle

      t.timestamps null: false
    end
  end
end
