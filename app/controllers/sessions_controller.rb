class SessionsController < ApplicationController
  # def create
  #   auth_hash = request.env['omniauth.auth']
  #   session[:user_id] = auth_hash["info"]["last_name"]
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path :flash => "Signed Out!"
  end

  # def create_instagram
  #   request.env["omniauth.auth"]
  # end

  def create_vimeo
    auth = request.env["omniauth.auth"]
    binding.pry
    au_user = AuUser.find_by_provider_and_uid(auth["provider"], auth["uid"]) || AuUser.create_with_omniauth(auth)
    session[:user_id] = au_user.id
    flash[:success] = "You've been signed in, #{ au_user.name }!"
    redirect_to root_url
  end

  private

  def vimeo_params
    params(request.env["omniauth.auth"]).require
  end
end
