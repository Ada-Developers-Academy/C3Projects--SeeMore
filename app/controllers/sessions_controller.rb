class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:create_instagram, :create_vimeo]

  def destroy
    session[:user_id] = nil
    flash[:success] = "Signed out!"
    redirect_to root_path
  end

  def create_instagram
    auth = request.env["omniauth.auth"]
    au_user = AuUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || AuUser.create_with_omniauth(auth)
    session[:user_id] = au_user.id
    flash[:success] = "You've been signed in, #{ au_user.name }!"
    redirect_to root_url
  end

  def create_vimeo
    auth = request.env["omniauth.auth"]
    au_user = AuUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || AuUser.create_with_omniauth(auth)
    session[:user_id] = au_user.id
    flash[:success] = "You've been signed in, #{ au_user.name }!"
    redirect_to root_url
  end
end
