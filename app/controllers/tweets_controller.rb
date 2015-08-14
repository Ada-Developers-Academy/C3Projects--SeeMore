class TweetsController < ApplicationController
  before_action :require_login, only: [:create]

  def search
    if params[:tweet][:username].present?
      username = params[:tweet][:username]
      @users = @twitter.client.user_search(username)
      @users.select! { |user| !user.protected? }
      if @users.empty?
        return redirect_to search_path, flash: { error: MESSAGES[:no_username] }
      else
        return render "feeds/search"
      end
    else
      redirect_to search_path, flash: { error: MESSAGES[:no_username] }
    end
  end

  def create
    user = User.find(session[:user_id])
    @twitter_person = Tweet.find_or_create_by(tweet_params)
    if @twitter_person.users.include?(user)
      already_following
    else
      @twitter_person.users << User.find(session[:user_id])
      redirect_to root_path, flash: { alert: MESSAGES[:success] }
    end
  end

  def destroy
    user = User.find_by(id: session[:user_id])
    tweeter = Tweet.find(params[:id])

    if tweeter
       user.tweets.destroy(tweeter)
    end

    redirect_to people_path, flash: { alert: MESSAGES[:target_eliminated] }
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
