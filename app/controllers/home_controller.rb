class HomeController < ApplicationController
  before_action :current_user
  before_action :require_signin, except: [:signin]

  include ActionView::Helpers::OutputSafetyHelper

  def signin
  end

  def newsfeed
    user = Followee.find(1)
    user_id = user.native_id.to_i
    tweet = @twitter_client.user_timeline(user_id, {count: 3}).first
    @tweet_html = get_embed_html(tweet.id)
    # raise
  end

  def get_embed_html(tweet_id)
    @twitter_client.oembed(tweet_id, { omit_script: true })[:html]
  end
end
