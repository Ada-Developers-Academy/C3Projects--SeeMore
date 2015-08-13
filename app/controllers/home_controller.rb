class HomeController < ApplicationController
  skip_before_action :require_signin, only: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  def signin; end

  def newsfeed
    subscriptions = @current_user.subscriptions.active
    ApiHelper.process_new_posts(subscriptions)

    if subscriptions.count == 0
      flash[:errors] = "You have no subscriptions! Search users to subscribe to."
    else
      @rev_posts = []
      subscriptions.each do |s|
        start = s.created_at
        posts = s.followee.posts
        posts_per_sub = []
        posts.each do |p|
          if p.native_created_at >= start
            posts_per_sub << p
          end
        end
        if posts_per_sub.count == 0
          posts_per_sub << posts.last
        end
        @rev_posts << posts_per_sub
      end
      @rev_posts.flatten!
      @rev_posts.sort_by! { |post| post.native_created_at }
      @rev_posts.reverse!
    end
  end

end
