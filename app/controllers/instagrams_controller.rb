require 'httparty'

class InstagramsController < ApplicationController
  INSTAGRAM_URI = "https://api.instagram.com/v1/users/"

  def search
    if params[:instagram].present?
      instagram_search = params[:instagram][:username]
      response = HTTParty.get(INSTAGRAM_URI + "search?q=#{instagram_search}&client_id=#{ENV["INSTAGRAM_ID"]}")

      @users = response["data"]

      return render "feeds/search"
    end

    redirect_to search_path
    # add flash: no search results were found for 'username'
  end

  private

  def instagram_params
    params.require(:instagram).permit(:username, :provider_id)
  end

end
