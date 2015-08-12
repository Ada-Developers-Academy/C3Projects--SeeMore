class PreyController < ApplicationController
  before_action :set_stalker
  before_action :find_or_create_prey

  def create
    if @stalker.prey.include?(@prey)
      flash[:message] = { success: "You were already following #{@prey.username}!" }
    elsif @stalker.prey << @prey
      flash[:message] = { success: "You are now following #{@prey.username}!" }
    else
      flash[:error] = { error: "We don't know what happened. We're very very sorry! >_>" }
    end

    redirect_to root_path
  end

  def unfollow
    if @stalker.prey.delete(@prey)
      flash[:message] = { success: "You have unsubscribed." }
    else
      flash[:error] = { error: "We don't know what happened. We're very very sorry! >_>" }
    end

    redirect_to dashboard_path(@stalker.id)
  end

  private

  def find_or_create_prey
    @prey = Prey.create_with(create_params)
    .find_or_create_by(uid: params[:uid], provider: params[:provider])

    unless @prey.persisted?
      flash[:error] = { error: "We don't know what happened. We're very very sorry! >_>" }
      redirect_to dashboard_path(session[:stalker_id])
    end
  end

  def create_params
    params.permit(:uid, :name, :username, :provider, :photo_url, :profile_url)
  end

  def set_stalker
    @stalker = Stalker.find(session[:stalker_id])
  end

end
