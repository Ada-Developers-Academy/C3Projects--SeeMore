require 'twitter'
require 'twit'

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :twit

  MESSAGES = {
    no_username: "There's no user by that name. Search again."
  }

  def twit
    @twitter ||= Twit.new
  end
end
