class TwiSubscriptionsController < ApplicationController

  def index
    client =  twitter_api_object
    @results = client.user_search(params[:twitter_search])
  end



end
