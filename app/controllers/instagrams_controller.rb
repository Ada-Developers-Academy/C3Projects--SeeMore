require 'httparty'
require 'instagram'

class InstagramsController < ApplicationController
  CALLBACK_URL = "http://localhost:3000/auth/instagram/callback"
  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"

  def index
    if params[:search]
      response = HTTParty.get(INSTAGRAM_URI + "search?q=#{params[:search]}")

      @users_list = response["data"].map do |hash|
        array = []
        array << hash["username"]
        array << hash["id"]
      end
    end
  end
end
