class AddForeignKeyIndicesToPosts < ActiveRecord::Migration
  def change
    add_index :tweets, :prey_id
    add_index :grams, :prey_id
  end
end
