class PostsController < ApplicationController
  def show
    name = params[:username]
    @posts = Post.where(username: name)
  end
end
