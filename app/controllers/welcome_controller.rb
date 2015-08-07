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
end
