class VimeoController < ApplicationController
  SEARCH_URI = "https://api.vimeo.com/users?per_page=30&query="

   def search
     user = params[:query]
     auth = HTTParty.get(SEARCH_URI + user + "&sort=relevant")
   end

  def results

  end

  def individual_feed

  end

  def subscribe
  end

  private
    def create_feed_attributes_from_API_junk(results)
    end

end
