class PostsController < ApplicationController
  def index
    unless session[:stalker_id]
      redirect_to landing_path
    end
    @stalker = Stalker.find(session[:stalker_id])
    @tweets = TwitterClient.user_timeline(3037739230) # TODO: Remember to update!!
  end
end
