class HomeController < ApplicationController
  skip_before_action :require_signin, only: [:signin]
  # before_action :twitter_api, only: [:get_new_posts, :find_twitter_params, :get_posts_from_API]

  include ActionView::Helpers::OutputSafetyHelper

  FIRST_POSTS_NUM = 5

  def signin; end

  def newsfeed
      subscriptions = @current_user.subscriptions.active
    if subscriptions.count == 0
      flash[:errors] = "You have no subscriptions! Search users to subscribe to."
    else
      @rev_posts = []
      subscriptions.each do |s|
        start = s.created_at
        s.followee.posts.each do |p|
          # if p.native_created_at >= start
            @rev_posts << p.embed_html
          # end
        end
      end
      @rev_posts.sort_by { |post| post["native_created_at"] }
    end
  end

  # def get_twitter_embed_html(tweet_id)
  #   @twitter_client.oembed(tweet_id, { omit_script: true })[:html]
  # end

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
    post_hash[:embed_html] = TwitterApi.new.embed_html_without_js(post.id)

    return post_hash
  end

  def find_instagram_params(post, followee)
    post_hash = {}
    post_hash[:native_id] = post["id"]
    post_hash[:native_created_at] = convert_instagram_time(post["created_time"])
    post_hash[:followee_id] = followee.id
    post_hash[:source] = followee.source
    post_hash[:embed_html] = InstagramApi.new.embed_html_with_js(post)

    return post_hash
  end

  def get_posts_from_API(followee)
    last_post_id = followee.last_post_id
    source = followee.source

    case source
    when TWITTER
      id = followee.native_id.to_i
      if last_post_id
        posts = TwitterApi.new.client.user_timeline(id, { since_id: last_post_id.to_i })
      else
        posts = TwitterApi.new.client.user_timeline(id, { count: 5 })
      end
    when INSTAGRAM
      id = followee.native_id
      posts = InstagramApi.new.get_posts(id, last_post_id)
    end

    posts
  end
end
