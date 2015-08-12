class FeedsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    Tweet.update_timeline(user)
    @tweets = user.tweets.chron_tweets
  end

  def search; end

  def search_redirect
    if params[:search_term].present?
      selected_params = { search_term: params[:search_term],
                          provider: params[:provider] }
      redirect_to search_results_path(selected_params)
    else
      redirect_to search_path(params[:provider])
    end
  end

  def search_results
    @search_term = params[:search_term]

    if params[:provider] == 'twitter'
      @results = @twit_init.client.user_search(@search_term)
    elsif params[:provider] == 'instagram'
      # TODO: move to ApplicationController & make an instance var like @twit_init?
      instagram_client = Instagram.client(:access_token => session[:access_token])
      @results = instagram_client.user_search(@search_term)
    else
      # guard
      # TODO: send flash notices
      redirect_to search_path(params[:provider])
    end
  end

  def tw_follow
    # binding.pry
    id = params[:tw_user]
    twitter_user = TwUser.find_or_create_by(tw_user_id_str: id)
    # TODO: Refactor so these assignments happen in another method

    twitter_user.update(twitter_params)

    our_user = User.find(session[:user_id])
    our_user.tw_users << [twitter_user]
    redirect_to :back
  end

  private

  def twitter_params
    params.permit(:tw_user_id_str, :user_name, :screen_name, :profile_image_url)
  end
end
