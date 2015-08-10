class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  FIRST_POSTS_NUM = 5

  def signin
  end

  def newsfeed
    # user = Followee.find(5)
    # user_id = user.native_id.to_i
    # tweet = @twitter_client.user_timeline(user_id, { count: 2 }).last
    # @tweet_html = get_embed_html(tweet.id)
    # raise
  end

  def get_embed_html(tweet_id)
    @twitter_client.oembed(tweet_id, { omit_script: true })[:html]
  end


  def get_new_posts
    active_subscriptions = @current_user.subscriptions.active

    active_subscriptions.each do |sub|
      followee = sub.followee
      last_post_id = sub.followee.last_post_id
      source = sub.followee.source

      posts = get_posts_from_API(source, followee, last_post_id)

      # twitter vs instagram
      if source == "twitter"
        posts.each do |post|
          Post.twitter_create(post)
        end
      elsif source == "instagram"
        posts.each do |post|
          Post.instagram_create(post)
        end
      end

      # id attr might be dif for instagram
      new_last_post_id = source == "twitter" ? posts.first.id : posts.first["id"]

      sub.followee.update!(last_post_id: new_last_post_id)
    end

    raise
  end

  # do we want to pass in followee or followee_id?
  def get_posts_from_API(source, followee, last_post_id)
    if source == "twitter"
      id = followee.native_id.to_i
      if followee.last_post_id
        posts = @twitter_client.user_timeline(id, { since_id: last_post_id.to_i })
      else
        posts = @twitter_client.user_timeline(id, { count: 5 } )
        return posts
      end
    elsif source == "instagram"
      if followee.last_post_id
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?min_id=" + last_post_id + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      else
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?count=" + FIRST_POSTS_NUM.to_s + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      end
        posts = response["data"]
    end
    raise
    return posts
  end



# identify current user (before_action)
# find active subscriptions for current user
  # for each subscription:
    # get followee_id
      # find last_post_id from that followee
    # if twitter...
    # if instagram...
    
    # hit API
      # find all new posts for that followee since that last_post_id -> present
      # returns a JSON object of all of them--ish

    # iterate through this collection
      # Post.new for each

    # update followee's last_post_id to be that of the last post you created

  # ... next subscription

end
