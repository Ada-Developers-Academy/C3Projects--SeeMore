class CreateFollowees < ActiveRecord::Migration
  def change
    create_table :followees do |t|
      t.string :handle
      t.string :source
      t.string :avatar_url

      t.timestamps null: false
    end
  end
end
