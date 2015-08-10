class TweetPostsController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    if user.tweets
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
      tweet_user_posts = Twit.user_timeline(username)
      tweet_user_posts.each do |post|
        @all_posts << {post_id: post.id, posted_at: post.created_at, text: post.text, media_url: post.entities.media.media_url, tweet_id: Tweet.find_by(provider_id: post.user.id) }
      end
    end
    return @all_posts
  end

end

# to get @user's feed
  # first, find all @user's people from Tweet table
  # for each person, retrieve all TweetPosts with that tweet_id fk, push them into a collection
    # (if none yet, aka first time following that person, then just fetch/create from API)
    # else, from all people's tweet_posts, find max posted_at time (most recent time)
    # pass that time also into Twitter API call to fetch tweets made since, save those to db
    # display tweets from db

  # from those people, give Twitter API their username to retrieve their tweets
  # for each person, call self.find_or_create_from_twitter_api on the API response to save all their tweets to the db
