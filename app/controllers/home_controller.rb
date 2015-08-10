class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  def signin
  end

  # def newsfeed
    # user = Followee.find(5)
    # user_id = user.native_id.to_i
    # tweet = @twitter_client.user_timeline(user_id, { count: 2 }).last
  #   @tweet_html = get_embed_html(tweet.id)
  #   # raise
  # end

  def refresh
    subscriptions = @current_user.subscriptions
    @all_posts = []
    subscriptions.each do |s|
      start = s.created_at
      s.posts.each do |p|
        if p.created_at >= start
          @all_posts << p
        end
      end
    end
    @all_posts.sort_by { |post| post["native_created_at"] }
    raise
    return @all_posts
    # render :more_news
  end

  def get_embed_html(tweet_id)
    @twitter_client.oembed(tweet_id, { omit_script: true })[:html]
  end
end
