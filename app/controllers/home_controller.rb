class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  def signin
  end

  def newsfeed
  end
end
