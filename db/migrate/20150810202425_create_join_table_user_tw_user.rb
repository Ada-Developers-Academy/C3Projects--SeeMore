class CreateJoinTableUserTwUser < ActiveRecord::Migration
  def change
    create_join_table :tw_users, :users do |t|
      t.index [:tw_user_id, :user_id]
      t.index [:user_id, :tw_user_id]
    end
  end
end
