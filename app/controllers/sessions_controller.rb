class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create, :if => proc { |c| Rails.env.development? }
  skip_before_filter :require_login, only: [:index, :create]

  def index; end

  def create
    auth_hash = request.env['omniauth.auth']
    stalker = Stalker.find_or_create_from_auth_hash(auth_hash)

    if stalker.persisted?
      session[:stalker_id] = stalker.id
      flash[:message] = { welcome: "You have logged in!" }
      redirect_to root_path
    else
      flash[:error] = stalker.errors
      redirect_to landing_path
    end
  end

  def destroy
    session[:stalker_id] = nil
    flash[:message] = { success: "You have signed out!" }
    redirect_to landing_path
  end

end
