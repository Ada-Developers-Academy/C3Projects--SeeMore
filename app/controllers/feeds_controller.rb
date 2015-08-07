class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    @people = Instagram.find(@user.instagram_ids)
  end

  def search; end
end
