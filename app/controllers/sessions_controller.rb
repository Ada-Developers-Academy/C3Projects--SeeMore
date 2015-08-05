class SessionsController < ApplicationController

  def login
    render :login
  end

  def create
    auth_hash = request.env['omniauth.auth']
    session[:user] = auth_hash["info"]["last_name"]
  end

  def destroy
    session[:user] = nil
    redirect_to '/auth/developer'
  end

  def create_instagram
    raise
    request.env["omniauth.auth"]
  end


end
