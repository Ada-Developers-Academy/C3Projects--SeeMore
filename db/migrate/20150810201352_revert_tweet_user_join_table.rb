require_relative "20150810171939_create_join_table_tweet_user"

class RevertTweetUserJoinTable < ActiveRecord::Migration
  def change
    revert CreateJoinTableTweetUser
  end
end
