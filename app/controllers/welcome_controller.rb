class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
  def index
    # reset_session # TODO: remove this before final PR. keep until no more rake db:reset
    if current_user
      posts = current_user.posts
      @posts = posts.only_thirty
      render :feed
    else
      render :login
    end
  end

  def page
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
      flash[:error] = "Please select Instagram or Vimeo from the search options."
      redirect_to :back

    else
      flash[:error] = "Please search for a user name."
      redirect_to :back
    end
  end
end
