class RenameTweetTableToPostTable < ActiveRecord::Migration
  def change
    rename_table :tweets, :posts
  end
end
