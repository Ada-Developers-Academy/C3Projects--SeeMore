require 'httparty'

class InstagramsController < ApplicationController
  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"

  def search
    if params[:instagram][:username]
      instagram_search = params[:instagram][:username]
      response = HTTParty.get(INSTAGRAM_URI + "search?q=#{instagram_search}&client_id=#{ENV["INSTAGRAM_ID"]}")

      @usernames = response["data"].collect do |user|
        user["username"]
      end

      return render "feeds/search"
    end

    redirect_to search_path
  end

  def callback  # NOTE: ADD NEW CALLBACK ROUTE TO THOSE IN IG FOR SITE.
    response = Instagram.get_access_token(params[:code], :redirect_uri => CALLBACK_URL)
    session[:access_token] = response.access_token
    redirect_to instagrams_path
  end
  # NOTE: WILL NEED BELOW LATER
  # def new
  #   @instagram = Instagram.new
  # end
  #
  # def create
  #   @instagram = Instagram.new(create_ig_params)
  #
  #   if @instagram.save
  #     redirect_to @back_url, notice: "Instagram User Added!"
  #   else
  #     flash.now[:errors] = "D'oh! We couldn't add your user!"
  #     # render :new
  #     redirect_to root_url
  #   end
  # end

  private

  def create_ig_params
    params.require(:instagram).permit(
      :username,
      :provider_id
    )
  end
end
