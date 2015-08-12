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

  def get_new_posts
    active_subscriptions = @current_user.subscriptions.active

    active_subscriptions.each do |sub|
      followee = sub.followee
      source = followee.source

      posts = get_posts_from_API(followee)

      if posts && posts.count > 0
        posts.each do |post|
          post_hash = Post.post_params(post, followee, source)
          Post.create(post_hash)
        end

        new_last_post_id = source == TWITTER ? posts.first.id : posts.first["id"]
        sub.followee.update!(last_post_id: new_last_post_id)
      end
    end

    redirect_to root_path
  end

  def get_posts_from_API(followee)
    last_post_id = followee.last_post_id
    source = followee.source

    case source
    when TWITTER
      id = followee.native_id.to_i
      posts = TwitterApi.new.get_posts(id, last_post_id)
    when INSTAGRAM
      id = followee.native_id
      posts = InstagramApi.new.get_posts(id, last_post_id)
    end

    posts
  end
end
