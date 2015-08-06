class PostsController < ApplicationController
  def index
    # We did this so that we could see the provider of the logged-in user on
    # the homepage
      @stalker = Stalker.find(session[:user_id])
    # TODO: fill this in
  end
end
