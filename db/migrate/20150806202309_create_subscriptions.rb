class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.references :user, index: true, foreign_key: true
      t.references :followee, index: true, foreign_key: true
      t.datetime :unsubscribe_date

      t.timestamps null: false
    end
  end
end
