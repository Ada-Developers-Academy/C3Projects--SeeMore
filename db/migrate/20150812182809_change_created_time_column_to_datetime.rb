class ChangeCreatedTimeColumnToDatetime < ActiveRecord::Migration
  def change
    remove_column :grams, :created_time
    add_column :grams, :created_time, :datetime
  end
end
