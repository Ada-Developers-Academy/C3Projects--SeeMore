class VimeoController < ApplicationController
   SEARCH_URI = "https://api.vimeo.com/users?per_page=30&query="

  def vimeo_user_search
    user = params[:query]
    auth = HTTParty.get(SEARCH_URI + user + "&sort=relevant")
  end


   
end
