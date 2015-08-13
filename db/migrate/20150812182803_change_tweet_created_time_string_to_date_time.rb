class ChangeTweetCreatedTimeStringToDateTime < ActiveRecord::Migration
  def change
    remove_column :tweets, :created_time
    add_column :tweets, :created_time, :datetime
  end
end
