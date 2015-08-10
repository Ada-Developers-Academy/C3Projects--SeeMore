require 'twitter_client'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :require_login

  def require_login
    redirect_to landing_path unless session[:stalker_id]
  end
end
