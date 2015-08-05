class IgSubscriptionsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :ig_subscriptions_users do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :ig_subscription, index: true, null: false
    end
  end
end
