class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  INSTA_URI = "https://api.instagram.com/v1/users/search?"
  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  FIRST_POSTS_NUM = 5

  def signin; end

  def newsfeed
    # user = Followee.find(5)
    # user_id = user.native_id.to_i
    # tweet = @twitter_client.user_timeline(user_id, { count: 2 }).last
    # @tweet_html = get_embed_html(tweet.id)
    # raise
    #### uncomment below for debugging example code
    @posts = []
    @current_user.followees.each do |f|
      f.posts.each do |p|
        @posts << p.embed_html
      end
    end
  end

  def get_twitter_embed_html(tweet_id)
    @twitter_client.oembed(tweet_id, { omit_script: true })[:html]
  end

  def get_instagram_embed_html(post)
    link = post["link"]
    HTTParty.get(INSTA_OEMBED_URI + link)["html"]
  end

  def get_new_posts
    active_subscriptions = @current_user.subscriptions.active

    active_subscriptions.each do |sub|
      followee = sub.followee
      last_post_id = sub.followee.last_post_id
      source = sub.followee.source

      posts = get_posts_from_API(source, followee, last_post_id)

      # twitter vs instagram
      if posts && posts.count > 0
        if source == "twitter"
          posts.each do |post|
            post_hash = find_twitter_params(post, followee)
            Post.create(post_hash)
          end
        elsif source == "instagram"
          posts.each do |post|
            post_hash = find_instagram_params(post, followee)
            Post.create(post_hash)
          end
        end

        new_last_post_id = source == "twitter" ? posts.first.id : posts.first["id"]
        sub.followee.update!(last_post_id: new_last_post_id)
      end
    end

    redirect_to root_path
  end


  def find_twitter_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post.id
    post_hash[:native_created_at] = post.created_at
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = get_twitter_embed_html(post.id)

    return post_hash
  end

  def find_instagram_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post["id"]
    post_hash[:native_created_at] = convert_instagram_time(post["created_time"])
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = get_instagram_embed_html(post)

    return post_hash
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
        real_last_id = (followee.last_post_id.to_i + 1).to_s
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?min_id=" + real_last_id + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      else
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?count=" + "5" + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      end
        posts = response["data"]
    end

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
