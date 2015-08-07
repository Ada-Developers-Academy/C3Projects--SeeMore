require 'httparty'

class InstagramsController < ApplicationController
  before_action :require_login, only: [:create]

  CALLBACK_URL = "http://localhost:3000/auth/instagram/callback"
  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"

  def search
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

  def create
    @instagram_person = Instagram.new(create_ig_params)
    @person = @instagram_person.username
    @instagram_person.users << User.find(session[:user_id])

    if @instagram_person.save
      redirect_to root_path(@person), flash: { alert: MESSAGES[:following_person] }
    else
      render "feeds/search", flash: { error: MESSAGES[:follow_error] }
    end
  end

  private

  def create_ig_params
    params.require(:instagram).permit(
      :username,
      :provider_id
    )
  end
end
