class FeedsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    Gram.collect_latest_posts(user, @instagram_client)
    @instagram_posts = user.grams
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
      @results = @instagram_client.user_search(@search_term)
    else
      # guard
      # TODO: send flash notices
      redirect_to search_path(params[:provider])
    end
  end

  def ig_follow
    user = User.find(session[:user_id])
    ig_account = params # hash of info
    ig_account = user.ig_follow(ig_account) # InstagramAccount obj
    redirect_to :back
  end
end
