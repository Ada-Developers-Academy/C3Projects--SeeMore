class TweetPostsController < ApplicationController
  before_action :require_login, only: [:create]

  def create
    user = User.find_by(id: session[:user_id])
    if user && user.tweets
      get_posts(user)

      @all_posts.each do |post|
        params[:tweet_post] = {
          post_id: post[:post_id],
          posted_at: post[:posted_at],
          text: post[:text],
          media_url: post[:media_url],
          tweet_id: post[:tweet_id]
        }
        TweetPost.find_or_create_by(tweet_post_params)
      end
      redirect_to root_path
    end
  end

  private

  def tweet_post_params
    params.require(:tweet_post).permit(:post_id, :posted_at, :text, :media_url, :tweet_id)
  end

  def get_posts(user)
    @all_posts = []
    usernames = user.tweets.map &:username
    usernames.each do |username|
      tweet_user_posts = @twitter.client.user_timeline(username, count: 10)
      tweet_user_posts.each do |post|
        @all_posts << { post_id: post.id, posted_at: post.created_at, text: post.text, tweet_id: Tweet.find_by(provider_id: post.user.id).id
        }
      end
    end
    return @all_posts
  end

end
