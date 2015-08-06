class TwiSubscriptionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :twi_subscriptions_users do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :twi_subscription, index: true, null: false
    end
  end
end
