class SessionsController < ApplicationController
  # So the dev login works in testing & development environments.
  skip_before_filter :verify_authenticity_token unless Rails.env.production?

  def create
    auth_hash = request.env['omniauth.auth']

    if auth_hash["uid"]
      @user = User.find_or_create_user(auth_hash)

      if auth_hash[:credentials][:token] != nil
        session[:access_token] = auth_hash[:credentials][:token]
      end

      if @user
        session[:user_id] = @user.id
      end

      redirect_to refresh_ig_path
    else
      flash[:error] = "Failed to authenticate"

      redirect_to root_path
    end
  end

  def destroy
    session[:user_id] = nil

    session[:access_token] = nil

    redirect_to root_path, notice: "You have fled from the beast!"
  end
end
