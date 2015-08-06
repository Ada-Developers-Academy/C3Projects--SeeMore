class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id

    redirect_to root_path
  end

  def home
    @current_user = User.find(session[:user_id])
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
