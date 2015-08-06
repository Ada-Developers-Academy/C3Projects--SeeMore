class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

  def create
    # possibilities
      # omniauth worked, @user has a auth Hash
        # redirect_to root_path with @user
      # request worked, no response
        # nothing to look up @user from db, can't init user
        # @user exists, session exists, but no ??
      # request didn't work
        # @user exists, nothing in auth hash
    @user = User.find_or_create_from_omniauth(auth_hash)
    session[:user_id] = @user.id

    if !@user.nil?
      redirect_to root_path
    else # user doesn't exist
      redirect_to root_path, notice: "Failed to authenticate"
    end
  end

  def home
    @current_user = User.find(session[:user_id])
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
