class PreyController < ApplicationController
  before_action :set_stalker
  before_action :set_prey

  def create
    if @prey.nil?
      @prey = Prey.create_from_username(params[:username])
    end
    @stalker.prey << @prey
    redirect_to root_path
  end

  def unfollow
    @stalker.prey.delete(@prey)
    redirect_to dashboard_path(@stalker.id)
  end

  private

  def set_prey
    @prey = Prey.find_by(username: params[:username])
  end

  def set_stalker
    @stalker = Stalker.find(session[:stalker_id])
  end

end
