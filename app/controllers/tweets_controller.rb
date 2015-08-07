class TweetsController < ApplicationController
  before_action :require_login, only: [:create]

  # to refactor into application controller, accepting params
  # def twitter_redirect
  #   if params[:username].present?
  #     redirect_to search_twitter_path(params[:username])
  #   else
  #     redirect_to root_path, flash: { error: MESSAGES[:no_username] }
  #   end
  # end

  def search
    if params[:username].present?
      username = params[:username]
      response = @twitter.client.user_search("#{username}")
    else
      redirect_to root_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def create
    @twitter_person = Tweet.new(tweet_params)
    @person = @twitter_person.username
    @twitter_person.users << User.find(session[:user_id])

    if @twitter_person.save
      return redirect_to root_path(@person), flash: { alert: MESSAGES[:following_person] }
    else
      return render "feeds/search", flash: { error: MESSAGES[:follow_error] }
    end
  end

  private

  def tweet_params
    params.require(:tweet).permit(
      :username,
      :provider_id
    )
  end
end
