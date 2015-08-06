class TweetsController < ApplicationController

  # to refactor into application controller, accepting params
  def twitter_redirect
    if params[:username].present?
      redirect_to search_twitter_path(params[:username])
    else
      redirect_to root_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def search
    @username = params[:username]
    @response = @twitter.client.user_search("#{@username}")
  end

end
