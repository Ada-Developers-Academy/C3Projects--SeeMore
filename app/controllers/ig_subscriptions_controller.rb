require 'httparty'

class IgSubscriptionsController < ApplicationController

  INSTA_URI = "https://api.instagram.com/v1/users/"

  def index
    @query = params[:instagram_search]

    access_token = session[:access_token]

    response = HTTParty.get(INSTA_URI + "search?q=#{@query}&access_token=" + access_token)

    @response = response["data"]
  end


end
