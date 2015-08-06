class TwiSubscriptionsController < ApplicationController

  def search
  client =  twitter_api_object
  client.user_search(params[:])
  
  end



end
