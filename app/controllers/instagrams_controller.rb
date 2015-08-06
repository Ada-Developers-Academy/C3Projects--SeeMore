require 'httparty'
require 'instagram'

class InstagramsController < ApplicationController
  CALLBACK_URL = "http://localhost:3000/auth/instagram/callback"
  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"

  # WIP: IG feed
  # NOTE: index -> connect -> callback -> index
  def connect
    auth_hash = request.env['omniauth.auth']
    redirect_to Instagram.authorize_url(redirect_uri: ig_callback_url, client_id: config.client_id)
  end

  def index
    if params[:search]
      response = HTTParty.get(INSTAGRAM_URI + "search?q=#{params[:search]}&client_id=#{ENV["INSTAGRAM_ID"]}")

      # client = Instagram.client(access_token: session[:access_token])
      #
      # response = HTTParty.get(INSTAGRAM_URI + "search?q=#{params[:search]}")
      @users_list = response["data"].map do |hash|
        array = []
        array << hash["username"]
        array << hash["id"]
      end

      # response = HTTParty.get(INSTAGRAM_URI + "search?q=#{params[:search]}")
      #
      # @users_list = response["data"].map do |hash|
      #   array = []
      #   array << hash["username"]
      #   array << hash["id"]
      # end
    end
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
