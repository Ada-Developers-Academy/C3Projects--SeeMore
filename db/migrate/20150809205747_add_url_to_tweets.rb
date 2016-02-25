class AddUrlToTweets < ActiveRecord::Migration
  def up
    add_column :tweets, :url, :string

    Tweet.all.each do |tweet|
      tweet.update(url: "https://twitter.com/")
    end

    change_column_null :tweets, :url, false
  end

  def down
    remove_column :tweets, :url
  end
end
