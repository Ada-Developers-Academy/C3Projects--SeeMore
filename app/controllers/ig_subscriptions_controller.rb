class IgSubscriptionsController < ApplicationController

  def index

    client = Instagram.client(:access_token => session[:access_token])
    @results = client.user_media_feed


  end

end
