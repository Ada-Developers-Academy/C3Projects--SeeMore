class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user

  private
    def current_user
      @current_user ||= AuUser.find(session[:user_id]) if session[:user_id]
    end

    def require_login
      redirect_to root_path unless session[:user_id]
    end
end
