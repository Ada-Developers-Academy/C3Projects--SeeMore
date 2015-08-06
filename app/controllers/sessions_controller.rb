class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def index

  end

  def create
    auth_hash = request.env['omniauth.auth']
    @stalker = Stalker.find_or_create_from_auth_hash(auth_hash)

    if @stalker.persisted?
      session[:stalker_id] = @stalker.id
      flash[:message] = { welcome: "You have logged in!" }
    else
      flash[:error] = @stalker.errors
    end

    redirect_to root_path
  end

  def destroy
    session[:stalker_id] = nil
    redirect_to landing_path
  end

end
