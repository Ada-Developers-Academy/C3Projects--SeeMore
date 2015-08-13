class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception # FIXME: these two callbacks are cancelling each other out
  skip_before_action :verify_authenticity_token # FIXME: resolve verify_authenticity_token madness
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
