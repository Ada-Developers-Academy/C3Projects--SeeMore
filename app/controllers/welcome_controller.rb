class WelcomeController < ApplicationController
  def index
    # reset_session # TODO: remove this before final PR. keep until no more rake db:reset
    if current_user
      @posts = current_user.posts.chronological.only_thirty
    end
  end
end
