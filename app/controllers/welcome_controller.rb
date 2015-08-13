class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index, :about]
  before_action :platform_check, only: [:instagram_feed, :vimeo_feed]

  def about; end

  def index
    if current_user
      posts = current_user.posts
      @posts = posts.only_thirty
      render :feed
    else
      render :login
    end
  end

  def instagram_feed
    @posts = @instagram_posts.take(30)
  end

  def vimeo_feed
    @posts = @vimeo_posts.take(30)
  end

  def search
    search = params.require(:search).permit(:query, :platform)
    if search[:platform] == "Vimeo" && search[:query].empty? == false
      redirect_to vimeo_results_path(search[:query])
    elsif search[:platform] == "Instagram" && search[:query].empty? == false
      redirect_to instagram_results_path(search[:query])
    elsif search[:platform] == nil
      redirect_to dual_results_path(search[:query])
    else
      flash[:error] = "Please search for a user name."
      redirect_to :back
    end
  end

  def dual_results
    @query = params[:query]
    vimeo_results = VimeoAPI.vimeo_search(@query)
    @vimeo_results = vimeo_results.each do |vimeo|
      vimeo["platform"] = "Vimeo"
    end

    instagram_results = InstagramAPI.instagram_search(@query)
    @instagram_results = instagram_results.each do |instagram|
      instagram["name"] = instagram["username"]
      instagram["platform"] = "Instagram"
    end

    @dual_results = (@instagram_results + @vimeo_results).sort_by {["name"]}
    @readable_search = @query.gsub('+', ' ')
  end

  def all_feeds
    @feeds = current_user.feeds.alphabetical
  end

  private
    def platform_check
      posts = current_user.posts.chronological

      @vimeo_posts = posts.select do |post|
        post.feed.platform == "Vimeo"
      end

      @instagram_posts = posts.select do |post|
        post.feed.platform == "Instagram"
      end
    end
end
