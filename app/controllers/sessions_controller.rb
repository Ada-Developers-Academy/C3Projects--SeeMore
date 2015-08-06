class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create

  def new

  end
  def create
    auth_hash = request.env['omniauth.auth']
    if auth_hash["provider"] == "developer"
      @user = Stalker.find_or_create_from_omniauth(auth_hash)
    elsif auth_hash["provider"] == "twitter"
      @user = Stalker.find_or_create_from_twitter(auth_hash)
    elsif auth_hash["provider"] == "instagram"
       @user = Stalker.find_or_create_from_instagram(auth_hash)
    elsif auth_hash["provider"] == "vimeo"
      @user = Stalker.find_or_create_from_vimeo(auth_hash)
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
