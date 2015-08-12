class Gram < ActiveRecord::Base
  #Associations
  belongs_to :instagram_user

# Scopes -----------------------------------------------------------------------
  scope :latest_posts, ->(limit) { order('created_at DESC').limit(limit) }

# Methods ----------------------------------------------------------------------
  def self.collect_latest_posts(user)
    followees = user.instagram_users

    followees.each do |account|
      last_post_id = account.grams.last.try :ig_id
      unless last_post_id == nil
        response = HTTParty.get("https://api.instagram.com/v1/users/#{account.ig_user_id}/media/recent/?min_id=#{last_post_id}&access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}")
      else # we have no posts of theirs on record
        response = HTTParty.get("https://api.instagram.com/v1/users/#{account.ig_user_id}/media/recent/?count=5&access_token=#{ENV['INSTAGRAM_ACCESS_TOKEN']}")
      end
      posts = response["data"] #this is an array of hashes.
      posts.reverse # changes it to ascending chronological order
      Gram.save_posts(posts)
    end

  end

  def self.save_posts(posts)
    posts.each do |post|
      account = InstagramUser.find_by(ig_user_id: post["user"]["id"])

      new_gram = Gram.new


      new_gram[:tags]               = post["tags"]
      new_gram[:media_type]         = post["type"]
      new_gram[:created_time]       = post["created_time"]
      new_gram[:link]               = post["link"]
      new_gram[:likes]              = post["likes"]["count"]
      new_gram[:image_url]          = post["images"]["standard_resolution"]["url"] # 640px
      new_gram[:caption]            = post["caption"]["text"] if post["caption"]
      new_gram[:ig_id]              = post["id"]
      new_gram[:ig_username]        = post["user"]["username"]
      new_gram[:ig_user_pic]        = post["user"]["profile_picture"]
      new_gram[:ig_user_id]         = post["user"]["id"]
      new_gram[:ig_user_fullname]   = post["user"]["full_name"]
      new_gram[:instagram_user_id]  = account.id

      new_gram.save
    end
  end
end
