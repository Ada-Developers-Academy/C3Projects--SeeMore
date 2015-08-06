class SessionsController < ApplicationController
skip_before_filter :verify_authenticity_token

  def create

    auth_hash = request.env['omniauth.auth']

    if auth_hash.credentials['token']
      session[:access_token] = auth_hash.credentials['token']
    end

    if auth_hash["uid"]
      @user = User.find_or_create_user(auth_hash)
      if @user
        session[:user_id] = @user.id

        redirect_to root_path
      else
        flash[:error] = "Failed to save the user"
        redirect_to root_path
      end
    else
      flash[:error] = "Failed to authenticate"
      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil

    redirect_to root_path, notice: "Log out successful"
  end
end
