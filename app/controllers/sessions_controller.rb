class SessionsController < ApplicationController

  def new; end

  def create
    auth_hash = request.env['omniauth.auth'] 
    # User.find_or_create_from_omniauth(auth_hash)

    # redirect_to root_path
  end
end
