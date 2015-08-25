class SessionsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: :create
  before_action :require_logged_out, except: [:destroy]

  MESSAGES = {
    signout_success: "Peep ya later!"
  }

  def new
    # Go to Instagram for authorization & confirmation
    redirect_to Instagram.authorize_url(:redirect_uri => callback_url)
  end

  def create
    # Come back to our site
    if params[:provider] == 'instagram'
      response = Instagram.get_access_token(params[:code], :redirect_uri => callback_url)
      session[:access_token] = response.access_token
      user = User.find_or_create_from_omniauth(response) # Returns a user obj. or nil
    else
      auth_hash = request.env['omniauth.auth']
      user = User.find_or_create_from_omniauth(auth_hash) # Returns a user obj. or nil
    end

    session[:user_id] = user.id
    session[:alert_msg] = true # Disclaimer message on feeds :index view

    redirect_to feeds_path
  end

  def show; end

  def destroy
    reset_session

    flash[:success] = MESSAGES[:signout_success]

    redirect_to root_path
  end
end
