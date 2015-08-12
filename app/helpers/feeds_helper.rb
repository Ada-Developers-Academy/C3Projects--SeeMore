module FeedsHelper
  def tweet_oembed(tweet)
    @twit_init.client.oembed(tweet.tw_id_str, { omit_script: true })[:html]
  end
end
