class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user && @user.instagrams
      @response = []
      @user.instagrams.each do |gram|
        @response << HTTParty.get(INSTAGRAM_URI + "#{gram.provider_id}/media/recent?access_token=#{session[:access_token]}")
      end
    end
  end

  def search; end

  def people
    @user = User.find_by(id: session[:user_id])
    if @user
      @people = Instagram.find(@user.instagram_ids) +  Tweet.find(@user.tweet_ids)
    end
  end

end
