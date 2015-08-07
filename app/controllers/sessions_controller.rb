class SessionsController < ApplicationController
  # ew, but a necessary ew :(
  skip_before_filter :verify_authenticity_token, only: :create

  def new
    # go to Instagram for authorization & confirmation
    redirect_to Instagram.authorize_url(:redirect_uri => callback_url)
  end

  def create
    # come back to our site
    if params[:provider] == 'instagram'
      response = Instagram.get_access_token(params[:code], :redirect_uri => callback_url)
      session[:access_token] = response.access_token
      session[:user_id] = User.find_by(uid: response.user.id).id

      auth_hash = request.env['omniauth.auth']
    end
    redirect_to feeds_path
  end

  def show
  end

end
