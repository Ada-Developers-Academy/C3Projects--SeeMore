class PreyController < ApplicationController

  def create
    prey = Prey.find_by(username: params[:username])
    unless prey.present?
      prey = Prey.create_from_username(params[:username])
    end
      stalker = Stalker.find(session[:stalker_id])
      stalker.prey << prey
    redirect_to root_path
  end

  # TODO: Add actions to the PreyController or delete the file!

end
