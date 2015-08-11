class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  skip_before_filter :require_signin

  def create
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id

    redirect_to root_path, notice: "Signed in!"
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
