class PostsController < ApplicationController
  def index
    unless session[:stalker_id]
      redirect_to landing_path
    end
    @stalker = Stalker.find(session[:stalker_id])
  end
end
