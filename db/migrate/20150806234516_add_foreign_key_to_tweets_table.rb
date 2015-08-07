class AddForeignKeyToTweetsTable < ActiveRecord::Migration
  def change
    add_column :tweets, :user_id, :integer
  end
end
