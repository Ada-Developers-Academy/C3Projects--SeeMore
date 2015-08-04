class SessionsController < ApplicationController

  def create
    auth_hash = request.env['omniauth.auth'] || params

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end
end
