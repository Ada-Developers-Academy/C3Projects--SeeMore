class PostsController < ApplicationController

  def show
    name = params[:username]
    @posts = Post.where(username: name).sorted_order
  end
end
