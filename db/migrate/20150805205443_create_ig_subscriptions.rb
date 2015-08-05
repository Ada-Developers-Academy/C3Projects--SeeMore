class CreateIgSubscriptions < ActiveRecord::Migration
  def change
    create_table :ig_subscriptions do |t|
      t.string :instagram_id

      t.timestamps null: false
    end
  end
end
