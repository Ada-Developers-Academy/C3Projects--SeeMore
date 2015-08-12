class ChangeTweetCreatedTimeStringToDateTime < ActiveRecord::Migration
  def change
    change_column :tweets, :created_time, :datetime
  end
end
