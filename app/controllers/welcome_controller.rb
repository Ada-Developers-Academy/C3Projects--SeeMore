class WelcomeController < ApplicationController
  skip_before_action :require_login, only: [:index]
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

  def search
    search = params.require(:search).permit(:query, :platform)
    if search[:platform] == "vimeo" && search[:query].empty? == false
      return redirect_to vimeo_results_path(search[:query])
    elsif search[:platform] == "instagram" && search[:query].empty? == false
      redirect_to instagram_results_path(search[:query])
    elsif search[:platform] == nil
      flash[:error] = "Please select instagram or vimeo."
      redirect_to :back
    else
      flash[:error] = "Please search for a user name?"
      redirect_to :back
    end
  end
end
