class WelcomeController < ApplicationController
  def index
    # reset_session # TODO: remove this before final PR. keep until no more rake db:reset
    if current_user
      posts = current_user.posts
      @posts = posts.only_thirty
    end
  end

  def search
    query = params.require(:search).permit(:query, :platform)
    if params[:platform] == "vimeo"
      raise
      return redirect_to vimeo_search_path(query[:query])
    else
      redirect_to  
    end
  end
end
