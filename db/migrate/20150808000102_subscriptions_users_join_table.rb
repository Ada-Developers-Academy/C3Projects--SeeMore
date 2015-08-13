class SubscriptionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :subscriptions_users do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :subscription, index: true, null: false
    end
  end
end
