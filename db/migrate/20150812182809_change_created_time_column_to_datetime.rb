class ChangeCreatedTimeColumnToDatetime < ActiveRecord::Migration
  def change
    change_column :grams, :created_time, :datetime
  end
end
