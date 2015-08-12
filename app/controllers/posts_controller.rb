class PostsController < ApplicationController
  def index
    @stalker = Stalker.find(session[:stalker_id])
    @posts = @stalker.order_posts
  end

  def update_feed
    prey = Stalker.find(session[:stalker_id]).prey
    prey.each do |prey|
      # this checks to make sure that we don't call update_posts for
      # prey who don't have any posts at all
      prey.update_posts unless Post.find_by(prey_id: prey.id).nil?
    end
    redirect_to root_path
  end
end
