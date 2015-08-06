class HomeController < ApplicationController

  def index

    client = twitter_api_object

    @elia = client.user_timeline("elia_mg")

  end
end
