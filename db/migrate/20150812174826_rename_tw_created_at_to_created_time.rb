class RenameTwCreatedAtToCreatedTime < ActiveRecord::Migration
  def change
    rename_column :tweets, :tw_created_at, :created_time
  end
end
