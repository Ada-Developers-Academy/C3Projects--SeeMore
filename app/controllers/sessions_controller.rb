class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def create
    auth_hash = request.env['omniauth.auth']
    @user = Stalker.find_or_create_from_auth_hash(auth_hash)

    if @user.persisted?
      session[:user_id] = @user.id
      flash[:message] = { welcome: "You have logged in!" }
    else
      flash[:error] = @user.errors
    end

    redirect_to root_path
  end
end
