class FeedsController < ApplicationController
  def index
    # user = User.find(session[:user_id])
    # instagram_client = Instagram.client(:access_token => session[:access_token])
    # instagram_posts = []

    # user.instagram_users.each do |ig_user|
    #   last_post_id = ig_user.grams.last.ig_id ||= nil
    #   unless last_post_id == nil
    #     posts = instagram_client.user_recent_media(ig_user.ig_user_id, { min_id: last_post_id })
    #     raise
    #   else
    #     instagram_client.user_recent_media(ig_user.ig_user_id, { count: 5 })
    #   end
    # end
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

  def ig_follow
    user = User.find(session[:user_id])
    ig_account = params # hash of info
    ig_account = user.ig_follow(ig_account) # InstagramAccount obj
    redirect_to :back
  end
end
