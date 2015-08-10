require 'httparty'
class IgSubscriptionsController < ApplicationController

  before_action :redirect_if_not_allowed

  INSTA_URI = "https://api.instagram.com/v1/users/"

  def index
    unless params[:instagram_search].nil?
      @query = params[:instagram_search]

      access_token = session[:access_token]

      response = HTTParty.get(INSTA_URI + "search?q=#{@query}&access_token=" + access_token)

      @response = response["data"]
    end
  end



  def create
    @instagram_id = params[:instagram_id]

    subscription = Subscription.find_or_create_ig_subscription(@instagram_id)


    @user.associate_subscription(subscription)

    flash[:notice] = "Subscribed successfully!"

    redirect_to root_path
  end


end
