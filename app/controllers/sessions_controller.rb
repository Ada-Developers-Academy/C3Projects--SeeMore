class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :require_signin

  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id

    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to signin_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
