require 'httparty'

class InstagramPostsController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    user = User.find_by(id: session[:user_id])
    if user && user.instagrams
      get_posts(user)

      # Check if db table includes each post;
      # if not, create new InstagramPost
      @all_posts.each do |post|
        params[:instagram_post] = {
          post_id: post[:post_id],
          instagram_id: post[:ig_id]
        }
        InstagramPost.find_or_create_by(instagram_post_params)
      end
    end
    redirect_to root_path
  end

  private

  def get_posts(user)
    # Get an array of all recent post ids associated with
    # all followed instagram users
    @all_posts = []
    user.instagrams.each do |gram|
      ig_user_posts = HTTParty.get(INSTAGRAM_URI + "users/#{gram.provider_id}/media/recent?count=10&access_token=#{session[:access_token]}")
      all_post_ids = ig_user_posts["data"].each do |post|
        @all_posts << { ig_id: gram.id, post_id: post["id"]}
      end
    end
    return @all_posts
  end

  def instagram_post_params
    params.require(:instagram_post).permit(:post_id, :instagram_id)
  end
end
