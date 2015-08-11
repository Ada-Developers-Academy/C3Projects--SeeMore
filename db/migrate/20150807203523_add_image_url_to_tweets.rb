class AddImageUrlToTweets < ActiveRecord::Migration
  def change
    add_column :tweets, :image_url, :string
  end
end
