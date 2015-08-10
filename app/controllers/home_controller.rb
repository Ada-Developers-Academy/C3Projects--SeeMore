class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  INSTA_USER_COUNT = "3"
  {user-id}/media/recent/?access_token=ACCESS-TOKEN

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
      followee_id = sub.followee_id
      last_post_id = sub.followee.last_post_id
      source = sub.followee.source

      posts = get_posts_from_API(source, followee_id, last_post_id)

      # twitter vs instagram
      posts.each do |post|
        Post.create(post)
      end

      # id attr might be dif for instagram
      new_last_post_id = posts.first.id

      sub.followee.update!(last_post_id: new_last_post_id)
    end
  end

  def get_posts_from_API(source, followee_id, last_post_id)
    if source == "twitter"
      posts = @twitter_client.user_timeline(
        followee_id.to_i, { since_id: last_post_id.to_i }
        )
    elsif source == "instagram"
      response = HTTParty.get(
        INSTA_USER_POSTS_URI + followee_id + "/media/recent/?min_id=" + last_post_id + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      posts = response["data"]
    end
    posts
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
