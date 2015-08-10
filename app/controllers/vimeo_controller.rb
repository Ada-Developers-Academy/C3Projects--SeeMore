class VimeoController < ApplicationController
   SEARCH_URI = "https://api.vimeo.com/users?per_page=30&query="
   TOKEN_HEADER = {  
                    "Accept" => "application/vnd.vimeo.*+json;version=3.2",
                    "Authorization" => "bearer #{ENV["VIMEO_ACCESS_TOKEN"]}" 
                  }
                   
  def results
    query = params[:query]
                
    auth = JSON.parse(HTTParty.get(SEARCH_URI + query + "&sort=relevant", :headers => TOKEN_HEADER ))
    @results = auth["data"]
  end


   
end
