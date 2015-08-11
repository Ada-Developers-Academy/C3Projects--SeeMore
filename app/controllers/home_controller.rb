class HomeController < ApplicationController
  skip_before_action :require_signin, only: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  INSTA_USER_POSTS_URI = "https://api.instagram.com/v1/users/"
  INSTA_OEMBED_URI = "http://api.instagram.com/oembed?omitscript=false&url="
  FIRST_POSTS_NUM = 5

  def signin; end

  def newsfeed
    subscriptions = @current_user.subscriptions
    @rev_posts = []
    subscriptions.each do |s|
      start = s.created_at
      s.followee.posts.each do |p|
        if p.created_at >= start
          @rev_posts << p.embed_html
        end
      end
    end
    @rev_posts.sort_by { |post| post["native_created_at"] }
  end

  # def newsfeed
    ### uncomment below for debugging example code
    # @posts = []
    # @current_user.followees.each do |f|
      # f.posts.each do |p|
        # @posts << p.embed_html
      # end
    # end
  # end

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
      source = followee.source

      posts = get_posts_from_API(followee)

      # twitter vs instagram
      if posts && posts.count > 0
        case source
        when TWITTER
          posts.each do |post|
            post_hash = find_twitter_params(post, followee)
            Post.create(post_hash)
          end
        when INSTAGRAM
          posts.each do |post|
            post_hash = find_instagram_params(post, followee)
            Post.create(post_hash)
          end
        end

        new_last_post_id = source == TWITTER ? posts.first.id : posts.first["id"]
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
  def get_posts_from_API(followee)
    last_post_id = followee.last_post_id
    source = followee.source

    case source
    when TWITTER
      id = followee.native_id.to_i
      if last_post_id
        posts = @twitter_client.user_timeline(id, { since_id: last_post_id.to_i })
      else
        posts = @twitter_client.user_timeline(id, { count: 5 })
      end
    when INSTAGRAM
      if last_post_id
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?min_id=" + last_post_id + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      else
        response = HTTParty.get(
          INSTA_USER_POSTS_URI + followee.native_id + "/media/recent/?count=" + "5" + "&access_token=" + ENV["INSTAGRAM_ACCESS_TOKEN"])
      end

      posts = response["data"]
      if posts && posts.count > 0
        posts = posts[0..-2]
      end
    end

    return posts
  end
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
