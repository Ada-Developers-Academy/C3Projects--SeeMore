class StalkersController < ApplicationController
  def index
    if params[:stalker_id].to_i == session[:stalker_id]
      @stalker = Stalker.find(session[:stalker_id])

      @twitter_prey = @stalker.prey.where(provider: "twitter")
      @instagram_prey = @stalker.prey.where(provider: "instagram")
    else
      flash[:error] = { restricted_access: "You cannot view another user's dashboard." }
      redirect_to root_path
    end
  end
end
