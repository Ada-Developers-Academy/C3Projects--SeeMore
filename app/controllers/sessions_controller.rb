class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["provider"] == "developer"
      @user = User.find_or_create_from_omniauth(auth_hash)
    elsif auth_hash["provider"] == "twitter"
    elsif auth_hash["provider"] == "instagram"
    else
      redirect_to root_path, notice: "Failed to authenticate"
    end

    if @user
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to root_path, notice: "Failed to save the user"
    end
  end
end
