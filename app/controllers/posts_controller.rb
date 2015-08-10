class PostsController < ApplicationController
  def index
    if session[:stalker_id]
      @stalker = Stalker.find(session[:stalker_id])
    else
      redirect_to landing_path
    end
  end
end
