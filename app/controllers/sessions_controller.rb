class SessionsController < ApplicationController
  # def create
  #   auth_hash = request.env['omniauth.auth']
  #   session[:user_id] = auth_hash["info"]["last_name"]
  # end

  def destroy
    session[:user_id] = nil
    redirect_to root_path :flash => "Signed Out!"
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
    # binding.pry
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

#<OmniAuth::AuthHash credentials=#<OmniAuth::AuthHash expires=false token="571376090.1113a83.b4fd15ef69c840e58b088bac9e53a8f7"> extra=#<OmniAuth::AuthHash> info=#<OmniAuth::AuthHash::InfoHash bio="💙❤️" image="https://igcdn-photos-a-a.akamaihd.net/hphotos-ak-xpa1/t51.2885-19/1597456_1553396424875024_384861688_a.jpg" name="Victoria" nickname="vikshab" website=""> provider="instagram" uid="571376090">
