require 'twitter'
require 'twitur'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :twitur

  private

  def twitur
    @twitter_client ||= Twitur.new
  end

end
