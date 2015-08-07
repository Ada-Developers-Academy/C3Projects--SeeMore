class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    if @user
      @people = Instagram.find(@user.instagram_ids)
    end
  end

  def search; end
end
