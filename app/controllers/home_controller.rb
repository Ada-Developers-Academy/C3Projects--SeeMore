class HomeController < ApplicationController
  def landing_page
    @current_user = User.find(session[:user_id])
  end

  def search
  end

  def find_twitter_users
  end
end
