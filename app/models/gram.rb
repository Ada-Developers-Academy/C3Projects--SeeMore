class Gram < ActiveRecord::Base
  #Associations
  belongs_to :instagram_user

# Scopes -----------------------------------------------------------------------
  scope :latest_posts, ->(limit) { order('created_at DESC').limit(limit) }

# Methods ----------------------------------------------------------------------
  def self.collect_latest_posts(user, instagram_client)
    following_accounts = user.instagram_users
    instagram_posts = []

    following_accounts.each do |account|
      last_post_id = account.grams.last.try :ig_id

      unless last_post_id == nil
        instagram_posts << instagram_client.user_recent_media(account.ig_user_id, { min_id: last_post_id })
      else # we have no posts of theirs on record
        instagram_posts << instagram_client.user_recent_media(account.ig_user_id, { count: 5 })
      end
    end

    Gram.save_posts(instagram_posts, user)
  end

  def self.save_posts(posts, user)
    number_of_posts = posts.count
    count = 0

    until count >= number_of_posts
      post = posts[count]
      account = InstagramUser.where(ig_user_id: post[0][:user][:id])[0]

      new_gram = Gram.new
      new_gram[:tags] = post[0][:tags]
      new_gram[:media_type] = post[0][:type]
      new_gram[:created_time] = post[0][:created_time]
      new_gram[:link] = post[0][:link]
      new_gram[:likes] = post[0][:likes][:count]
      new_gram[:image_url] = post[0][:images][:standard_resolution][:url] # 640px
      new_gram[:caption] = post[0][:caption][:text]
      new_gram[:ig_id] = post[0][:id]
      new_gram[:ig_username] = post[0][:user][:username]
      new_gram[:ig_user_pic] = post[0][:user][:profile_picture]
      new_gram[:ig_user_id] = post[0][:user][:id]
      new_gram[:ig_user_fullname] = post[0][:user][:full_name]
      new_gram[:instagram_user_id] = account.id

      new_gram.save
      count += 1
    end
  end
end
