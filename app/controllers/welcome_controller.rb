class WelcomeController < ApplicationController
  def index
    # reset_session # TODO: remove this before final PR. keep until no more rake db:reset
    if current_user
      posts = current_user.posts
      @posts = posts.only_thirty
    end
  end

  def search
    search = params.require(:search).permit(:query, :platform)
    if search[:platform] == "vimeo"
      return redirect_to vimeo_results_path(search[:query])
    elsif search[:platform] == "instagram"
      redirect_to instagram_results_path(search[:query])
    else
      flash[:error] = "Please select instagram or vimeo"
      redirect_to :back
    end
  end
end
