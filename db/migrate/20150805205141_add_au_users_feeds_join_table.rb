class AddAuUsersFeedsJoinTable < ActiveRecord::Migration
  def change
    create_join_table :au_users, :feeds do |t|
      t.index [:au_user_id, :feed_id]
      t.index [:feed_id, :au_user_id]
    end
  end
end
