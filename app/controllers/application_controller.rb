require 'twitter'
require 'twit_init'
require 'instagram'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :twit_init, :ig_client
  helper_method :client

  private

  def twit_init
    @twit_init ||= TwitInit.new
  end

  def ig_client
    @instagram_client = Instagram.client(:access_token => session[:access_token])
  end

  # def client
  # @client ||= User.find(session[:user_id]) if session[:user_id]
  # end
end
