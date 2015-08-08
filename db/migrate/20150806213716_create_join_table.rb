class CreateJoinTable < ActiveRecord::Migration
  def change
    create_join_table :instagrams, :users do |t|
      t.index :instagram_id
      t.index :user_id
    end
  end
end
