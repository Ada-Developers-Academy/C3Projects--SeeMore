class PostsController < ApplicationController

  def show
    name = params[:id]
    @posts = Post.where(username: name)
  end
end
