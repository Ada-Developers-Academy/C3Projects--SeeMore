require 'httparty'

class InstagramsController < ApplicationController
  before_action :require_login, only: [:create]

  CALLBACK_URL = "https://ninjaparty.herokuapp.com/auth/instagram/callback"

  def search
    if params[:instagram][:username].present?
      instagram_search = params[:instagram][:username].gsub!(/\s+/, "")
      response = HTTParty.get(INSTAGRAM_URI + "users/search?q=#{instagram_search}&client_id=#{ENV["INSTAGRAM_ID"]}")
      @users = response["data"]

      if @users.empty?
        return redirect_to search_path, flash: { error: MESSAGES[:no_username] }
      else
        return render "feeds/search"
      end
    else
      redirect_to search_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def create
    user = User.find(session[:user_id])
    @instagram_person = Instagram.find_or_create_by(instagram_params)
    response = HTTParty.get(INSTAGRAM_URI + "users/#{@instagram_person.provider_id}/media/recent?access_token=#{session[:access_token]}")

    if @instagram_person.users.include?(user)
      already_following
    elsif response["meta"]["error_message"]
      private_ig_user(response)
    else
      @instagram_person.users << User.find(session[:user_id])
      redirect_to root_path, flash: { alert: MESSAGES[:success] }
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    instagramer = Instagram.find(params[:id])
    if instagramer
       user.instagrams.destroy(instagramer)
       instagramer.users.destroy(user)
    end

    redirect_to people_path, flash: { alert: MESSAGES[:target_eliminated] }
  end

  private

  def instagram_params
    params.require(:instagram).permit(:username, :provider_id, :image_url)
  end

end
