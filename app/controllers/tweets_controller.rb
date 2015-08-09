class TweetsController < ApplicationController
  before_action :require_login, only: [:create]

  def search
    if params[:tweet][:username].present?
      username = params[:tweet][:username]
      @users = @twitter.client.user_search(username)
      # @feed = @twitter.client.user_timeline(username, count: 1)
      return render "feeds/search"
    else
      redirect_to search_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def create
    @twitter_person = Tweet.find_or_create_by(tweet_params)
    @person = @twitter_person.username
    @twitter_person.users << User.find(session[:user_id])

    if @twitter_person.save
      return redirect_to root_path, flash: { alert: MESSAGES[:success] }
    else
      return render "feeds/search", flash: { error: MESSAGES[:follow_error] }
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    tweeter = Tweet.find(params[:id])

    if tweeter
       user.tweets.destroy(tweeter)
    end

    redirect_to people_path, flash: { alert: MESSAGES[:success] }
  end

  private

  def tweet_params
    params.require(:tweet).permit(
      :username,
      :provider_id,
      :image_url
    )
  end
end
