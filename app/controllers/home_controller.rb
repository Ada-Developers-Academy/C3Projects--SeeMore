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
      @show_posts = []
      subscriptions.each do |s|
        posts_per_sub = []
        all_sub_posts = s.posts
        sub_posts = s.rev_posts
        if sub_posts.count == 0
          posts_per_sub << all_sub_posts.last
        end
      @show_posts << posts_per_sub
      end
    end
    if @show_posts
      @show_posts.flatten!
      @show_posts.sort_by! { |p| p.native_created_at }
      @show_posts.reverse!
    end
  end

end
