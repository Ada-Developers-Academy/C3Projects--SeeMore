class ChangeColumnNameToPostTime < ActiveRecord::Migration
  def change
    rename_column :tweets, :tweet_time, :post_time
    rename_column :grams, :gram_time, :post_time
  end
end
