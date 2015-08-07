class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user
      @people = []
      @people << Instagram.find(@user.instagram_ids)
      @people << Tweet.find(@user.tweet_ids)
      @people.flatten!
      @people.sort_by! { |person| person.username.downcase }
    end
  end

  def search; end
end
