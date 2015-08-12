class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :instagrams, :users do |t|
      t.index [:instagram_id, :user_id], unique: true
    end
  end
end
