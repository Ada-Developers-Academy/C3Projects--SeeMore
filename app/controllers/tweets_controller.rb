class TweetsController < ApplicationController
  before_action :require_login, only: [:create]

  def search
    if params[:tweet].present?
      username = params[:tweet][:username]
      @users = @twitter.client.user_search(username)
      
      return render "feeds/search"
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
