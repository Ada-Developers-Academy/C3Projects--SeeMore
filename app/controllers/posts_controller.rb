class PostsController < ApplicationController
  def index
    @stalker = Stalker.find(session[:stalker_id])
    @posts = Post.all # TODO: Remember to update!!
  end
end
