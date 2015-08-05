class SessionsController < ApplicationController

  def login
  end
  
  def create
    auth_hash = request.env['omniauth.auth']
    session[:user] = auth_hash["info"]["last_name"]
  end

  def destroy
    session[:user] = nil
    redirect_to '/auth/developer'
  end
end
