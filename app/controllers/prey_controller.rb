class PreyController < ApplicationController
  def create
    prey = Prey.find_by(username: params[:username])
    if prey.present?
      stalker = Stalker.find(session[:stalker_id])
      stalker.prey << prey
    else
      Prey.create_from_username(params[:username])
    end
    redirect_to root_path
  end
end
