class PostsController < ApplicationController
  def index
    @stalker = Stalker.find(session[:stalker_id])
  end
end
