class FeedsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
  end

  def search; end
end
