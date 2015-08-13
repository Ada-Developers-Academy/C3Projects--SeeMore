class ApplicationController < ActionController::Base
  include ApplicationHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :assign_user

  private

    def assign_user
      if logged_in?
        @user = User.find(session[:user_id])
      end
    end

    def redirect_if_not_allowed
      unless logged_in?
        flash[:error] = "You must be logged in to see that."
        redirect_to root_path
      end
    end
  end
