require 'httparty'

class InstagramsController < ApplicationController
  before_action :require_login, only: [:create]

  CALLBACK_URL = "http://localhost:3000/auth/instagram/callback"

  def search
    if params[:instagram][:username].present?
      instagram_search = params[:instagram][:username]
      response = HTTParty.get(INSTAGRAM_URI + "search?q=#{instagram_search}&client_id=#{ENV["INSTAGRAM_ID"]}")

      @users = response["data"]

      return render "feeds/search"
    else
      redirect_to search_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def create
    @instagram_person = Instagram.find_or_create_by(instagram_params)
    @person = @instagram_person.username
    @instagram_person.users << User.find(session[:user_id])

    if @instagram_person.save
      return redirect_to root_path, flash: { alert: MESSAGES[:success] }
    else
      return render "feeds/search", flash: { error: MESSAGES[:follow_error] }
    end
    redirect_to search_path
    # add flash: no search results were found for 'username'
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    instagramer = Instagram.find(params[:id])

    if instagramer
       user.instagrams.destroy(instagramer)
    end

    redirect_to people_path, flash: { alert: MESSAGES[:success] }
  end

  private

  def instagram_params
    params.require(:instagram).permit(:username, :provider_id, :image_url)
  end

end
