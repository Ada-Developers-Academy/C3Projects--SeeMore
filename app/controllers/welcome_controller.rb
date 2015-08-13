class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index, :about]

  def about; end

  def index
    #reset_session # TODO: remove this before final PR. keep until no more rake db:reset
    if current_user
      posts = current_user.posts
      @posts = posts.only_thirty
      render :feed
    else
      render :login
    end
  end

  def view_instagram_feed
    if current_user
      platform_check
      @posts = @instagram_posts.take(30)
      render :instagram_feed
    else
      render :login
    end
  end

  def view_vimeo_feed
    if current_user
      platform_check
      @posts = @vimeo_posts.take(30)
      render :vimeo_feed
    else
      render :login
    end
  end

  def page # FIXME: delete if no paginate
    posts = current_user.posts.chronological
    start = (params[:page_number].to_i * 30) + 1
    @posts = posts[start, 30]
  end

  def search
    search = params.require(:search).permit(:query, :platform)
    if search[:platform] == "Vimeo" && search[:query].empty? == false
      redirect_to vimeo_results_path(search[:query])
    elsif search[:platform] == "Instagram" && search[:query].empty? == false
      redirect_to instagram_results_path(search[:query])
    elsif search[:platform] == nil
      # flash[:error] = "Please select Instagram or Vimeo from the search options."
      redirect_to dual_results_path(search[:query])
    else
      flash[:error] = "Please search for a user name."
      redirect_to :back
    end
  end

  def dual_results
    @query = params[:query]
    @vimeo_results = VimeoAPI.vimeo_search(@query)
    @vimeo_results.each do |vimeo|
      vimeo["platform"] = "Vimeo"
    end
    @instagram_results = InstagramAPI.instagram_search(@query)
    @instagram_results = @instagram_results.each do |instagram|
      instagram["name"] = instagram["username"]
      instagram["platform"] = "Instagram"
    end
    @dual_results = (@instagram_results + @vimeo_results).sort_by {["name"]}
  end

  def platform_check
    posts = current_user.posts.chronological
    @vimeo_posts = posts.select do |post|
      post.feed.platform == "Vimeo"
    end
    @instagram_posts = posts.select do |post|
      post.feed.platform == "Instagram"
    end
  end

  def all_feeds
    @feeds = current_user.feeds.alphabetical
  end
end
