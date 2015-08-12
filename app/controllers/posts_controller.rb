class PostsController < ApplicationController
  def index
    @stalker = Stalker.find(session[:stalker_id])
    @posts = @stalker.order_posts
  end

  def update_feed
    stalker = Stalker.find(session[:stalker_id])
    prey = stalker.prey
    prey.each do |prey|
      prey.update_posts
    end
    redirect_to root_path
  end

end
