class PostsController < ApplicationController
  def index
    @stalker = Stalker.find(session[:stalker_id])
    @posts = @stalker.order_posts
  end
end
